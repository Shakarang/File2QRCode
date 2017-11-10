//
//  QRCode.swift
//  File2QRCode
//
//  Created by Maxime Junger on 05/11/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import Foundation

/// QRCode object with its content
class QRCode: Codable {

	/// Data contained into the QR Code
	let codeData: CodeData

	/// Checksum of the data to ensure it is not corrupted
	let checksum: String

	enum CodingKeys: String, CodingKey {
		case codeData = "data"
		case checksum
	}

	var isValid: Bool {
		
		return true
	}
}

extension QRCode {
	
	class func fromStringData(_ value: String) -> QRCode? {
		let decoder = JSONDecoder()
		do {
			let data = value.data(using: .utf8)!
			let code = try decoder.decode(QRCode.self, from: data)
			return code
		} catch let e {
			print(e)
			return nil
		}
	}
}
