//
//  ActionButton.swift
//  File2QRCode
//
//  Created by Maxime Junger on 21/10/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import UIKit

class ActionButton: UIButton {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code

		self.layer.backgroundColor = UIColor.secondColor.cgColor

		self.tintColor = .mainColor

		self.clipsToBounds = true
		self.layer.cornerRadius = 6

		self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    }
}
