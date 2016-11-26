//
//  UIControl+Helper.swift
//  NoStoryboards
//
//  Created by Ritesh Gupta on 10/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

private var didTapAssociativeKey = "didTapAssociativeKey"

extension UIControl: Tapable {

	public var didTap: TapHandler? {
		get { return objc_getAssociatedObject(self, &didTapAssociativeKey) as? TapHandler }
		set {
			addTarget(
				self,
				action: #selector(UIBarButtonItem._didTap(sender:)),
				for: .touchUpInside
			)
			objc_setAssociatedObject(self, &didTapAssociativeKey, newValue, .OBJC_ASSOCIATION_RETAIN)
		}
	}
	
	func _didTap(sender: UIBarButtonItem) { didTap?.value() }
	
}
