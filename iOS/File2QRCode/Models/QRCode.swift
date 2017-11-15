//
//  QRCode.swift
//  File2QRCode
//
//  Created by Maxime Junger on 05/11/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import Foundation
import CryptoSwift

/// QRCode object with its content
class QRCode: Codable {

	/// Data contained into the QR Code
	let codeData: CodeData

	/// Checksum of the data to ensure it is not corrupted
	let checksum: String

	private(set) var isValid: Bool = true

	enum CodingKeys: String, CodingKey {
		case codeData = "data"
		case checksum
	}
}

// MARK: - Code validity
extension QRCode {
	func check() {
		let encoder = JSONEncoder()
		guard let data = try? encoder.encode(codeData) else {
			self.isValid = false
			return
		}

		// Remove slash escaping characters
		let codeString = String(data: data, encoding: .utf8)?.replacingOccurrences(of: "\\/", with: "/") ?? ""

		if codeString.sha256() == self.checksum {
			self.isValid = true
		}
	}
}

// MARK: - Static initialiser
extension QRCode {
	
	/// Init a QR Code object with a string JSON
	///
	/// - Parameter value: JSON in string
	/// - Returns: QRCode object if the decode went well. Nil otherwise.
	class func fromStringData(_ value: String) -> QRCode? {
		let decoder = JSONDecoder()
		do {
			let data = value.data(using: .utf8)!
			let code = try decoder.decode(QRCode.self, from: data)
			code.check()
			return code
		} catch let e {
			print(e)
			return nil
		}
	}
}
