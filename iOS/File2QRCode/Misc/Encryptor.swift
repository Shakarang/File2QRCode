//
//  Encryptor.swift
//  File2QRCode
//
//  Created by Maxime Junger on 12/11/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import Foundation
import CryptoSwift

class Encryptor {

	/// Salt used for password derivation
	static let salt: [UInt8] = Array("File2QRCodeSalt".utf8)

	/// Encrypts the given string using the given password.
	/// To cipher the string, a key derivation is performed using PBKDF2.
	///
	/// - Parameters:
	///   - string: String to encrypt
	///   - password: Password to use to encrypt
	/// - Returns: String ciphered and encoded in base 64
	class func encrypt(_ string: String, toAESWithPassword password: String) -> String? {

		/// Key used to perform AES
		var key = Array(password.utf8)

		do {
			// Derive password to get 16 byte initialisaton vector
			let initialisationVector = try PKCS5.PBKDF2(password: key,
														salt: Encryptor.salt,
														iterations: 4096,
														variant: HMAC.Variant.md5).calculate()

			// Derive password to get a 32 byte key
			key = try PKCS5.PBKDF2(password: key,
								   salt: salt,
								   iterations: 4096,
								   variant: HMAC.Variant.sha256).calculate()

			let encrypted = try AES(key: key, blockMode: .CBC(iv: initialisationVector), padding: .pkcs7).encrypt(Array(string.utf8))

			return encrypted.toBase64()
		} catch let error {
			print(error)
			return nil
		}
	}
}
