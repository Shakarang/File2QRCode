//
//  AssembleViewController.swift
//  File2QRCode
//
//  Created by Maxime Junger on 21/10/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import UIKit

final class AssembleViewController: UIViewController {

	@IBOutlet weak var shareButton: ActionButton!

	// MARK: - Initialisation

	private var recoveredFile: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

		self.setUI()
    }

	private func setUI() {

		self.view.backgroundColor = .mainColor

		self.setShareButton()
	}

	private func setShareButton() {
		self.shareButton.setTitle("Share", for: .normal)
		self.shareButton.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
	}

	@objc private func shareAction() {

		let vc = PasswordProtectViewController.build(withRecoveredFile: self.recoveredFile)

		self.navigationController?.pushViewController(vc, animated: true)
	}
}

extension AssembleViewController {
	class func build(withCodes codes: [Int: QRCode]) -> AssembleViewController {

		let vc = AssembleViewController(nibName: nil, bundle: nil)

		var recovered = ""

		for index in 0..<codes.count {
			recovered.append(codes[index]!.codeData.content)
		}

		vc.recoveredFile = recovered

		return vc
	}
}
