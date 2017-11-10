//
//  StatusCollectionViewCell.swift
//  File2QRCode
//
//  Created by Maxime Junger on 10/11/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import UIKit

class StatusCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var itemInformationLabel: UILabel!

	var activityIndicator: UIActivityIndicatorView?

	weak var code: QRCode?

	static var reuseIdentifier: String {
		return "StatusCollectionViewCell"
	}

	static var nib: UINib {
		return UINib(nibName: StatusCollectionViewCell.reuseIdentifier, bundle: nil)
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

		self.setUI()
    }

	func setInformationLabel(withCode code: QRCode) {
		self.code = code
		self.itemInformationLabel.text = "\(code.codeData.id + 1)"

		self.imageView.image = UIImage(named: "check_symbol")!.withRenderingMode(.alwaysTemplate)
		self.imageView.tintColor = .validColor

		self.activityIndicator?.stopAnimating()
		self.activityIndicator = nil
	}

	func setInformationLabel(withPosition position: Int) {
		self.itemInformationLabel.text = "\(position + 1)"

		self.imageView.image = nil

		self.createActivityAnimator()
		self.addSubview(activityIndicator!)
	}

	private func setUI() {

		self.clipsToBounds = true
		self.layer.cornerRadius = 3

		self.itemInformationLabel.backgroundColor = .clear
		self.itemInformationLabel.textColor = .black

		self.backgroundColor = .clear
	}

	private func createActivityAnimator() {
		self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)

		self.activityIndicator!.hidesWhenStopped = true
		self.activityIndicator!.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
		self.activityIndicator!.center = CGPoint.init(x: self.frame.size.width / 2,
													  y: (self.frame.size.height - self.itemInformationLabel.frame.height) / 2)
		self.activityIndicator!.isUserInteractionEnabled = false

		self.activityIndicator!.startAnimating()
	}
}
