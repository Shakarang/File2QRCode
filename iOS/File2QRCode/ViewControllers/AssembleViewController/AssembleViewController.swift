//
//  AssembleViewController.swift
//  File2QRCode
//
//  Created by Maxime Junger on 21/10/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import UIKit

final class AssembleViewController: UIViewController {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var shareButton: ActionButton!

	// MARK: - Initialisation

	private var recoveredString: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

		self.setUI()
    }

	private func setUI() {

		self.view.backgroundColor = .mainColor

		self.setShareButton()

		// Title label
		self.titleLabel.font = UIFont.titleFont
		self.titleLabel.text = String.localized(withKey: .fileRecoveredTitle)

		// Description label
		self.descriptionLabel.font = UIFont.descriptionFont
		self.descriptionLabel.text = String.localized(withKey: .fileRecoveredDescription)
	}

	private func setShareButton() {
		self.shareButton.setTitle(String.localized(withKey: .share), for: .normal)
		self.shareButton.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
	}

	/// Action called when user presses the Share button.
	@objc private func shareAction() {
		let vc = PasswordProtectViewController.build(withRecoveredString: self.recoveredString)
		self.navigationController?.pushViewController(vc, animated: true)
	}
}

extension AssembleViewController {

	/// Build AssembleViewController controller by initialising its recoveredString property with the given codes
	///
	/// - Parameter codes: Read codes
	/// - Returns: AssembleViewController
	class func build(withCodes codes: [Int: QRCode]) -> AssembleViewController {

		let vc = AssembleViewController(nibName: nil, bundle: nil)

		var recovered = ""

		for index in 0..<codes.count {
			recovered.append(codes[index]!.codeData.content)
		}

		vc.recoveredString = recovered

		return vc
	}
}
