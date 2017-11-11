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

	@IBOutlet weak var statusView: ScannerStatusView!
	
	@IBOutlet weak var statusViewBottomConstraint: NSLayoutConstraint!

	// MARK: - Initialisation

	private let captureSession: AVCaptureSession = AVCaptureSession()

	private var videoPreviewLayer: AVCaptureVideoPreviewLayer?

	private lazy var qrCodeFrameView: UIView = self.codeFrameView()

	weak var delegate: ScannerViewControllerDelegate?

	private var codes = [Int: QRCode]()

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.

		self.codeCaptureInitialisation()

		self.statusViewBottomConstraint.constant = self.statusView.frame.height

		self.statusView.delegate = self
		self.statusView.codes = self.codes
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

		self.view.bringSubview(toFront: self.statusView)
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

		self.statusViewBottomConstraint.constant = 0

		UIView.animate(withDuration: 0.5) {
			self.view.layoutIfNeeded()
		}

//		self.captureSession.stopRunning()

		guard let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
			metadataObject.type == .qr
			else { return }

		if let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObject) {
			qrCodeFrameView.frame = barCodeObject.bounds
		}

		if let codeValue = metadataObject.stringValue {
			self.delegate?.didFind(value: codeValue)
		}
	}

}

extension ScannerViewController: ScannerViewControllerDelegate {
	func didFind(value: String) {

		guard let code = QRCode.fromStringData(value) else {
			return
		}

		if self.codes[code.codeData.id] != nil {
			return // Item already exists
		}

		if self.codes.count == 0 {
			// First element, enables status view
			self.statusView.codesNumber = code.codeData.elementsNumber
		}

		self.codes[code.codeData.id] = code
		self.statusView.codes = self.codes
	}
}

extension ScannerViewController: ScannerStatusViewDelegate {

	func shouldGoNext() {
		let vc = AssembleViewController.build(withCodes: self.codes)
		self.navigationController?.pushViewController(vc, animated: true)
	}

}

extension ScannerViewController {
	class func build() -> ScannerViewController {
		let vc = ScannerViewController(nibName: nil, bundle: nil)
		vc.delegate = vc
		return vc
	}
}
