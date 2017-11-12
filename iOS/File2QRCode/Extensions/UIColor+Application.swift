//
//  UIColor+Application.swift
//  File2QRCode
//
//  Created by Maxime Junger on 21/10/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

	/// Main color of the application
	static var mainColor: UIColor {
		return UIColor.white
	}

	static var secondColor: UIColor {
		return UIColor(red: 0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
	}

	/// QR Code border color
	static var codeColor: UIColor {
		return .mainColor
	}

	static var validColor: UIColor {
		return UIColor(red: 46.0/255.0, green: 204.0/255.0, blue: 113.0/255.0, alpha: 1.0)
	}

	static var errorColor: UIColor {
		return UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
	}

}

extension UIColor {

	func lighter(by percentage:CGFloat=30.0) -> UIColor? {
		return self.adjust(by: abs(percentage) )
	}

	func darker(by percentage:CGFloat=30.0) -> UIColor? {
		return self.adjust(by: -1 * abs(percentage) )
	}

	func adjust(by percentage:CGFloat=30.0) -> UIColor? {
		var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
		if(self.getRed(&r, green: &g, blue: &b, alpha: &a)){
			return UIColor(red: min(r + percentage/100, 1.0),
						   green: min(g + percentage/100, 1.0),
						   blue: min(b + percentage/100, 1.0),
						   alpha: a)
		}else{
			return nil
		}
	}
}
