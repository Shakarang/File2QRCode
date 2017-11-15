//
//  String+Localization.swift
//  File2QRCode
//
//  Created by Maxime Junger on 15/11/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import Foundation

extension String {

	enum LocalizationKey: String {
		// Main VC
		case startRecoveringTitle = "START_RECOVERING_TITLE"
		case applicationDescription = "APPLICATION_DESCRIPTION"
		case checkRepoGithub = "CHECK_REPO_GITHUB"

		// Finished scanning VC
		case fileRecoveredTitle = "FILE_RECOVERED_TITLE"
		case fileRecoveredDescription = "FILE_RECOVERED_DESCRIPTION"

		// Password setter VC
		case passwordFieldPlaceholder = "PASSWORD_FIELD_PLACEHOLDER"
		case encryptionDescription = "ENCRYPTION_DESCRIPTION"

		// Buttons
		case scan = "SCAN"
		case next = "NEXT"
		case share = "SHARE"
		case goBackToMenu = "GO_TO_BACK_MENU"
		case cancel = "CANCEL"

	}

	static func localized(withKey key: LocalizationKey) -> String {
		return NSLocalizedString(key.rawValue, comment: "")
	}
}
