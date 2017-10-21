//
//  NoScanView.swift
//  File2QRCode
//
//  Created by Maxime Junger on 21/10/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import UIKit

class NoScanView: UIView {

	init() {
		super.init(frame: CGRect.zero)
		fromNib()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		fromNib()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		fromNib()
	}
}
