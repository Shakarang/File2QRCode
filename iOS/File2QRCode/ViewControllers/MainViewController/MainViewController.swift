//
//  MainViewController.swift
//  File2QRCode
//
//  Created by Maxime Junger on 21/10/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

	// MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Builder
extension MainViewController {

	class func build() -> MainViewController {
		return MainViewController(nibName: "MainViewController", bundle: nil)
	}
}
