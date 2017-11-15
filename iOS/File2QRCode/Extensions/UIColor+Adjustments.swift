//
//  UIColor+Adjustments.swift
//  File2QRCode
//
//  Created by Maxime Junger on 13/11/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

	/// Returns a lighter color
	///
	/// - Parameter percentage: Percentage of lightning
	/// - Returns: New color
	func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
		return self.adjust(by: abs(percentage) )
	}

	/// Returns a darker color
	///
	/// - Parameter percentage: Percentage of dark
	/// - Returns: <#return value description#>
	func darker(by percentage: CGFloat = 30.0) -> UIColor? {
		return self.adjust(by: -1 * abs(percentage) )
	}

	private func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
		var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
		if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
			return UIColor(red: min(r + percentage/100, 1.0),
						   green: min(g + percentage/100, 1.0),
						   blue: min(b + percentage/100, 1.0),
						   alpha: a)
		} else {
			return nil
		}
	}
}
