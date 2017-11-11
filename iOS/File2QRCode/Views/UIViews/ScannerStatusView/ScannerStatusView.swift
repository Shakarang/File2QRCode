//
//  ScannerStatusView.swift
//  File2QRCode
//
//  Created by Maxime Junger on 06/11/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import UIKit

protocol ScannerStatusViewDelegate: class {
	func shouldGoNext()
}

class ScannerStatusView: UIView {
	
	@IBOutlet var contentView: UIView!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var nextButton: UIButton!

	private var viewHeightConstraint: NSLayoutConstraint?

	weak var delegate: ScannerStatusViewDelegate?
	
	var codes: [Int: QRCode] = [:] {
		didSet {
			self.collectionView.reloadData()
			if self.codes.count > 0 && self.codes.count == codesNumber {
				self.ending()
			}
		}
	}

	var codesNumber: Int = 0 {
		didSet {
			self.collectionView.reloadData()
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}

	private func setup() {
		Bundle.main.loadNibNamed("ScannerStatusView", owner: self, options: nil)
		guard let content = contentView else { return }
		content.frame = self.bounds
		content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		self.contentView = content
		self.addSubview(content)

		self.initUI()
	}

	override func awakeFromNib() {
		self.viewHeightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.bounds.height)
		self.viewHeightConstraint?.isActive = true
		self.addConstraint(self.viewHeightConstraint!)
	}

	private func initUI() {

		self.contentView.backgroundColor = .clear
		self.backgroundColor = .clear

		let effect = UIBlurEffect(style: .light)
		let visualEffectView = UIVisualEffectView(effect: effect)
		visualEffectView.frame = self.bounds
		self.addSubview(visualEffectView)

		self.sendSubview(toBack: visualEffectView)

		self.nextButton.isHidden = true
		self.setNextButton()

		self.initCollectionView()
	}

	private func initCollectionView() {
		self.collectionView.dataSource = self

		self.collectionView.delegate = self

		self.collectionView.register(StatusCollectionViewCell.nib,
									 forCellWithReuseIdentifier: StatusCollectionViewCell.reuseIdentifier)

		self.collectionView.backgroundColor = .clear
		self.collectionView.showsHorizontalScrollIndicator = false

		(self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset = .init(top: 0, left: 8, bottom: 0, right: 8)
	}

	private func ending() {

		self.collectionView.removeFromSuperview()
		self.nextButton.isHidden = false

		self.viewHeightConstraint?.constant = 76
		UIView.animate(withDuration: 0.5) {
			self.superview?.layoutIfNeeded()
		}
	}

	private func setNextButton() {
		self.nextButton.setTitle("Next", for: .normal)
		self.nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
	}

	@objc private func nextButtonPressed() {
		self.delegate?.shouldGoNext()
	}
}

// MARK: - UICollectionViewDataSource
extension ScannerStatusView: UICollectionViewDataSource {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.codesNumber
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		// swiftlint:disable force_cast
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatusCollectionViewCell.reuseIdentifier, for: indexPath) as! StatusCollectionViewCell
		// swiftlint:enable force_cast

		if let code = self.codes[indexPath.row] {
			cell.setInformationLabel(withCode: code)
		} else {
			cell.setInformationLabel(withPosition: indexPath.row)
		}

		return cell
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ScannerStatusView: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 90, height: 90)
	}
}
