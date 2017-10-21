//
//  UIView+Initialisation.swift
//  File2QRCode
//
//  Created by Maxime Junger on 21/10/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

	@discardableResult
	func fromNib<T: UIView>() -> T? {

		guard let contentView = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
			return nil
		}
		self.addSubview(contentView)
		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.layoutAttachAll(to: self)
		return contentView
	}

	func layoutAttachAll(to parentView: UIView) {
		var constraints = [NSLayoutConstraint]()
		self.translatesAutoresizingMaskIntoConstraints = false
		constraints.append(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: parentView, attribute: .left, multiplier: 1.0, constant: 0))
		constraints.append(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: parentView, attribute: .right, multiplier: 1.0, constant: 0))
		constraints.append(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1.0, constant: 0))
		constraints.append(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1.0, constant: 0))
		parentView.addConstraints(constraints)
	}
}
