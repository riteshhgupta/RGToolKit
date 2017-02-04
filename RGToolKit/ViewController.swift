//
//  ViewController.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 26/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var picker: ImagePickerService?
	
	let imagePickerConfig = ImagePickerService.Configuration(
		sourceType: .camera,
		allowsEditing: true
	)
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if picker == nil {
			picker = ImagePickerService(configuration: imagePickerConfig, controller: self)
			picker?.image({ (result) in
				print(result)
			})
		}
	}
}
