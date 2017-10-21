//
//  MainViewController.swift
//  File2QRCode
//
//  Created by Maxime Junger on 21/10/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

	@IBOutlet weak var contentView: UIView!

	enum State {
		case initial, started
	}

	private var state: State = .initial {
		didSet {
			self.setContentView()
		}
	}

	// MARK: - Initialisation

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	override func viewWillAppear(_ animated: Bool) {
		self.setContentView()
	}

	private func setContentView() {

		switch self.state {
		case .initial:
			let scanView = NoScanView(frame: self.contentView.bounds)
			self.contentView.addSubview(scanView)
			scanView.layoutAttachAll(to: self.contentView)
		case .started:
			break
		}
	}
}

// MARK: - ScannerViewControllerDelegate
extension MainViewController: ScannerViewControllerDelegate {
	func didFind(value: String) {
		print("Found value")
	}
}

// MARK: - Builder
extension MainViewController {

	class func build() -> MainViewController {
		return MainViewController(nibName: "MainViewController", bundle: nil)
	}
}
