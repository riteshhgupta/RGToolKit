//
//  UIColor+Extension.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 13/12/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
	public convenience init(hex: UInt32) {
		self.init(hex: hex, alpha: 1)
	}
	public convenience init(hex: UInt32, alpha: CGFloat) {
		let red = byteColor(x: hex >> 16)
		let green = byteColor(x: hex >> 8)
		let blue = byteColor(x: hex)
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
}

private func byteColor(x: UInt32) -> CGFloat {
	return CGFloat(x & 0xFF) / 255
}

