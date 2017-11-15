//
//  ActionButton.swift
//  File2QRCode
//
//  Created by Maxime Junger on 21/10/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

	var customBackgroundColor: UIColor = .secondColor
	var customTintColor: UIColor = .mainColor
	var customBorderColor: UIColor?

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code

		self.layer.backgroundColor = self.customBackgroundColor.cgColor

		self.tintColor = self.customTintColor

		self.clipsToBounds = true
		self.layer.cornerRadius = 6

		if let borderColor = self.customBorderColor {
			self.layer.borderWidth = 1
			self.layer.borderColor = borderColor.cgColor
		}

		self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    }

	func lightColors() {
		self.customTintColor = .secondColor
		self.customBackgroundColor = .white
		self.customBorderColor = .secondColor
	}
}
