//
//  UIFont+Application.swift
//  File2QRCode
//
//  Created by Maxime Junger on 14/11/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {

	/// Font for title elements
	static var titleFont: UIFont {
		return UIFont.systemFont(ofSize: 34, weight: .semibold)
	}

	/// Font for description elements
	static var descriptionFont: UIFont {
		return UIFont.systemFont(ofSize: 15, weight: .regular)
	}
}
