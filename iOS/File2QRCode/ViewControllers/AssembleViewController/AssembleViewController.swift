//
//  AssembleViewController.swift
//  File2QRCode
//
//  Created by Maxime Junger on 21/10/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import UIKit

final class AssembleViewController: UIViewController {

	// MARK: - Initialisation

	private var recoveredFile: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
