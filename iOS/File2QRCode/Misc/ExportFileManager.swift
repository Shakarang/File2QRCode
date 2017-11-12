//
//  FileManager.swift
//  File2QRCode
//
//  Created by Maxime Junger on 12/11/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import Foundation

class ExportFileManager {

	class func createFile(named name: String, withContent content: String) -> URL? {

		if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

			let fileURL = dir.appendingPathComponent(name)

			do {
				try content.write(to: fileURL, atomically: false, encoding: .utf8)
				return fileURL
			}
			catch let error {
				print(error)
			}
		}
		return nil
	}

	class func deleteFile(atURL url: URL) {
		do {
			try FileManager.default.removeItem(at: url)
		} catch {
			//
		}
	}
}
