//
//  NSObjectProtocol.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 27/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

public extension NSObjectProtocol {

	public var className: String {
		let type = type(of: self)
		return String(describing: type)
	}
	
	public static var className: String {
		let type = type(of: self)
		let value = String(describing: type).components(separatedBy: ".").first
		return value!
	}
	
	public var nib: UINib {
		return UINib(nibName: className, bundle: nil)
	}
	
	public static var nib: UINib {
		return UINib(nibName: className, bundle: nil)
	}
}
