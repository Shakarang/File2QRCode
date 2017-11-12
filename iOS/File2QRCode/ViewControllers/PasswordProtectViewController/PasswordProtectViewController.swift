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

		self.informationLabel.textColor = .secondColor
		self.informationLabel.text = "AES 256 BLABLABLA"

		self.passwordTextField.backgroundColor = UIColor.mainColor.darker(by: 10)
		self.passwordTextField.superview?.backgroundColor = self.passwordTextField.backgroundColor
		self.passwordTextField.tintColor = .secondColor
		self.passwordTextField.textColor = .secondColor
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

		guard let password = self.passwordTextField.text else {
			return
		}

		let res = Encryptor.encrypt(self.recoveredString, toAESWithPassword: password)

		print(res!)

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
