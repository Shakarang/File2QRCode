//
//  NoScanView.swift
//  File2QRCode
//
//  Created by Maxime Junger on 21/10/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import UIKit
import SafariServices

class NoScanView: UIView {

	@IBOutlet var view: UIView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var githubButton: UIButton!

	private let githubRepoString = "https://github.com/Shakarang/File2QRCode"

	init() {
		super.init(frame: CGRect.zero)
		self.fromNib()
		self.initElements()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.fromNib()
		self.initElements()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.fromNib()
		self.initElements()
	}

	private func initElements() {

		self.backgroundColor = .mainColor
		self.view.backgroundColor = .mainColor

		// Title
		self.titleLabel.text = "Start recovering your files"
		self.titleLabel.font = UIFont.titleFont

		// Description
		self.descriptionLabel.text = "Scan all your QR codes generated with File2QRCode desktop application in order to retrieve your entire file."
		self.descriptionLabel.font = UIFont.descriptionFont

		// Github Button
		self.githubButton.setTitle("Check the repo on Github", for: .normal)
		self.githubButton.setTitleColor(.secondColor, for: .normal)
		self.githubButton.addTarget(self, action: #selector(goToRepo), for: .touchUpInside)
		self.githubButton.titleLabel?.font = self.githubButton.titleLabel?.font.withSize(15)
	}

	@objc private func goToRepo() {
		let svc = SFSafariViewController(url: URL(string: self.githubRepoString)!)

		var topVC = UIApplication.shared.keyWindow?.rootViewController
		while topVC!.presentedViewController != nil {
			topVC = topVC!.presentedViewController
		}
		topVC?.present(svc, animated: true, completion: nil)
	}
}
