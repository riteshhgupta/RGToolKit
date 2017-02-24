//
//  ImagePickerService.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 04/02/17.
//  Copyright © 2017 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

open class ImagePickerService: NSObject {
	
	public typealias ImageResult = Result<UIImage, ImageError>
	public typealias ImageHandler = Closure<ImageResult, Void>
	
	let picker = UIImagePickerController()
	let configuration: Configuration
	
	public var imageHandler: ImageHandler?
	weak var controller: UIViewController?
	
	public init(configuration: Configuration = Configuration.default, controller: UIViewController) {
		self.configuration = configuration
		self.controller = controller
	}
	
	public func image(_ handler: @escaping ImageHandler) {
		imageHandler = handler
		showPicker(sourceType: configuration.sourceType)
	}
	func showPicker(sourceType: UIImagePickerControllerSourceType) {
		picker.sourceType = sourceType
		picker.allowsEditing = configuration.allowsEditing
		picker.delegate = self
		controller?.present(picker, animated: true, completion: nil)
	}
}

extension ImagePickerService: UIImagePickerControllerDelegate {
	
	func sendResult(_ result: ImageResult) {
		imageHandler?(result)
		picker.dismiss(animated: true, completion: nil)
	}
	public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		sendResult(Result.error(.userCancellation))
	}
	public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		let mediaKey = configuration.allowsEditing ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage
		guard let image = info[mediaKey] as? UIImage else { sendResult(Result.error(.extraction)); return }
		sendResult(Result.value(image))
	}
}

extension ImagePickerService: UINavigationControllerDelegate {}

extension ImagePickerService {
	
	public struct Configuration {
		
		public let sourceType: UIImagePickerControllerSourceType
		public let allowsEditing: Bool
		
		static var `default`: Configuration {
			return Configuration(
				sourceType: .photoLibrary,
				allowsEditing: true
			)
		}
	}
}


extension ImagePickerService {
	
	public enum ImageError: Error {
		case userCancellation
		case extraction
		case configuration
		case unknown
	}
}
