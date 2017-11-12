//
//  PasswordProtectViewController.swift
//  File2QRCode
//
//  Created by Maxime Junger on 12/11/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import UIKit
import CryptoSwift

class PasswordProtectViewController: UIViewController {

	@IBOutlet weak var safeboxImageView: UIImageView!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var informationLabel: UILabel!
	@IBOutlet weak var nextButton: ActionButton!

	private var recoveredString: String!

	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.setUI()
    }

	private func setUI() {

		self.view.backgroundColor = .mainColor

		self.informationLabel.textColor = .black
		self.informationLabel.text = "Before sharing, please set a password in order to protect your data. It will be encrypted using AES-256, the safest encryption algorithm in the world. You'll be able to recover your data using the File2QRCode desktop tool."

		self.passwordTextField.backgroundColor = UIColor.mainColor.darker(by: 10)
		self.passwordTextField.superview?.backgroundColor = self.passwordTextField.backgroundColor
		self.passwordTextField.tintColor = .black
		self.passwordTextField.textColor = .black
		self.passwordTextField.isSecureTextEntry = true
		self.passwordTextField.placeholder = "Enter your password"
		self.passwordTextField.delegate = self

		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		self.view.addGestureRecognizer(tap)

		self.nextButton.isEnabled = false
		self.nextButton.setTitle("Share", for: .normal)
		self.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
		
	}

	@objc private func dismissKeyboard() {
		self.view.endEditing(true)
	}

	@objc private func nextButtonClicked() {

		guard let password = self.passwordTextField.text,
			let encrypted = Encryptor.encrypt(self.recoveredString, toAESWithPassword: password) else {
			return
		}

		let file = "file2QRCodeAES.txt"

		guard let fileURL = ExportFileManager.createFile(named: file, withContent: encrypted) else {
			return
		}

		let controller = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)

		controller.excludedActivityTypes = [.postToFacebook, .postToVimeo, .postToFlickr, .postToTwitter, .postToTencentWeibo, .postToWeibo]
		controller.completionWithItemsHandler = { (activityType, completed, items, error) in
			// When user has shared the data, we delete the file
			ExportFileManager.deleteFile(atURL: fileURL)
		}

		self.present(controller, animated: true, completion: nil)
	}
}

extension PasswordProtectViewController: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		self.nextButton.isEnabled = (textField.text?.count ?? 0) > 0
	}
}

extension PasswordProtectViewController {
	class func build(withRecoveredFile recovered: String) -> PasswordProtectViewController {
		let vc = PasswordProtectViewController(nibName: nil, bundle: nil)
		vc.recoveredString = recovered
		return vc
	}
}
