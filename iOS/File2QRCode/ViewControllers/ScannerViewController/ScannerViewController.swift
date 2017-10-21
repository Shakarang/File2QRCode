//
//  ScannerViewController.swift
//  File2QRCode
//
//  Created by Maxime Junger on 21/10/2017.
//  Copyright © 2017 Maxime Junger. All rights reserved.
//

import UIKit
import AVFoundation

/// Scanner code detection delegate
protocol ScannerViewControllerDelegate: class {

	/// Found QR Code with value.
	///
	/// - Parameter value: Code value.
	func didFind(value: String)
}

final class ScannerViewController: UIViewController {

	// MARK: - Initialisation

	let captureSession: AVCaptureSession = AVCaptureSession()

	var videoPreviewLayer: AVCaptureVideoPreviewLayer?

	lazy var qrCodeFrameView: UIView = self.codeFrameView()

	weak var delegate: ScannerViewControllerDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.

		self.codeCaptureInitialisation()
	}

	private func codeCaptureInitialisation() {

		// Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
		guard let captureDevice = AVCaptureDevice.default(for: .video) else {
			print("Error initialising the capture device.")
			return
		}

		do {
			// Get an instance of the AVCaptureDeviceInput class using the previous device object.
			let input = try AVCaptureDeviceInput(device: captureDevice)

			// Set the input device on the capture session.
			self.captureSession.addInput(input)

			// Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
			let captureMetadataOutput = AVCaptureMetadataOutput()
			self.captureSession.addOutput(captureMetadataOutput)

			// Set delegate and use the default dispatch queue to execute the call back
			captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
			captureMetadataOutput.metadataObjectTypes = [.qr]
		} catch {
			print(error)
			return
		}

		// Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
		self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
		self.videoPreviewLayer?.videoGravity = .resizeAspectFill
		self.videoPreviewLayer?.frame = view.layer.bounds
		self.view.layer.addSublayer(videoPreviewLayer!)

		// Start video capture.
		self.captureSession.startRunning()
	}

	private func codeFrameView() -> UIView {

		let codeFrameView = UIView()

		codeFrameView.layer.borderColor = UIColor.green.cgColor
		codeFrameView.layer.borderWidth = 2

		self.view.addSubview(codeFrameView)
		self.view.bringSubview(toFront: codeFrameView)

		return codeFrameView
	}
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate
extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {

	func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
		
		if metadataObjects.count == 0 {
			qrCodeFrameView.frame = CGRect.zero
			print("Notihing detected")
			return
		}

		self.captureSession.stopRunning()

		guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
			metadataObject.type == .qr
			else { return }

		if let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) {
			qrCodeFrameView.frame = barCodeObject.bounds
		}

		if let codeValue = metadataObject.stringValue {
			self.delegate?.didFind(value: codeValue)
			self.dismiss(animated: true, completion: nil)
		}
	}

}

extension ScannerViewController {
	class func build() -> ScannerViewController {
		return ScannerViewController(nibName: nil, bundle: nil)
	}
}
