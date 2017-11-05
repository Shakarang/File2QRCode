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
}
