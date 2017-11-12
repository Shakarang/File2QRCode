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
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var githubLinkLabel: UILabel!

	private let githubRepoString = "https://github.com/Shakarang/File2QRCode"

	init() {
		super.init(frame: CGRect.zero)
		fromNib()
		self.initElements()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		fromNib()
		self.initElements()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		fromNib()
		self.initElements()
	}

	private func initElements() {

		self.backgroundColor = .mainColor
		self.view.backgroundColor = .mainColor

		// Description
		self.descriptionLabel.text = "Scan all your QR codes generated with File2QRCode desktop application in order to retrieve your entire file."

		// Github link
		let underlineAttribute = [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]
		let githubLinkString = NSAttributedString(string: self.githubRepoString, attributes: underlineAttribute)
		self.githubLinkLabel.attributedText = githubLinkString
		self.githubLinkLabel.font = self.githubLinkLabel.font.withSize(13)

		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goToRepo))
		self.githubLinkLabel.isUserInteractionEnabled = true
		self.githubLinkLabel.addGestureRecognizer(tapGesture)
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
