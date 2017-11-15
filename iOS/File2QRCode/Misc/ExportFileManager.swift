//
//  FileManager.swift
//  File2QRCode
//
//  Created by Maxime Junger on 12/11/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import Foundation

/// Manager to deal with file storage
class ExportFileManager {

	/// Creates file with the name given and writes the content in it
	///
	/// - Parameters:
	///   - name: Name of the created file
	///   - content: Content to set to write to the file
	/// - Returns: URL of the file if it worked, nil if it failed
	class func createFile(named name: String, withContent content: String) -> URL? {

		if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

			let fileURL = dir.appendingPathComponent(name)

			do {
				try content.write(to: fileURL, atomically: false, encoding: .utf8)
				return fileURL
			} catch let error {
				print(error)
			}
		}
		return nil
	}

	/// Delets file at URL
	///
	/// - Parameter url: URL of the file
	class func deleteFile(atURL url: URL) {
		do {
			try FileManager.default.removeItem(at: url)
		} catch {
			//
		}
	}
}
