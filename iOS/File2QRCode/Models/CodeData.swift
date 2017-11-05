//
//  CodeData.swift
//  File2QRCode
//
//  Created by Maxime Junger on 05/11/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import Foundation

/// Data contained in the QR Code
class CodeData: Codable {

	/// ID of the QR Code, its position in the number of elements
	let id: Int

	/// QR Code data
	let content: String

	/// Total number of QR codes
	let elementsNumber: Int

	enum CodingKeys: String, CodingKey {
		case id
		case content
		case elementsNumber = "elements"
	}
}
