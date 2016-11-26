//
//  UIButton+Extension.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 26/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
	
	convenience init(frame: CGRect, tapHandler: TapHandler) {
		self.init(frame: frame)
		didTap = tapHandler
	}
	
	convenience init(tapHandler: TapHandler) {
		self.init()
		didTap = tapHandler
	}
	
	convenience init(type buttonType: UIButtonType, tapHandler: TapHandler) {
		self.init(type: buttonType)
		didTap = tapHandler
	}
}
