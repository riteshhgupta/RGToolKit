//
//  UIBarButtonItem+Helper.swift
//  NoStoryboards
//
//  Created by Ritesh Gupta on 10/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

private var didTapAssociativeKey = "didTapAssociativeKey"

extension UIBarButtonItem {
	
	public convenience init(image: UIImage?, style: UIBarButtonItemStyle) {
		self.init(image: image, style: style, target: nil, action: nil)
	}
	
	@available(iOS 5.0, *)
	public convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItemStyle, tapHandler: TapHandler? = nil) {
		self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
		didTap = tapHandler
	}
	
	public convenience init(title: String?, style: UIBarButtonItemStyle, tapHandler: TapHandler? = nil) {
		self.init(title: title, style: style, target: nil, action: nil)
		didTap = tapHandler
	}
	
	public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, tapHandler: TapHandler? = nil) {
		self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
		didTap = tapHandler
	}
	
	public convenience init(customView: UIView, tapHandler: TapHandler? = nil) {
		self.init(customView: customView)
		didTap = tapHandler
	}
}

extension UIBarButtonItem: Tapable {
	
	public var didTap: TapHandler? {
		get { return objc_getAssociatedObject(self, &didTapAssociativeKey) as? TapHandler }
		set {
			target = self
			action = #selector(UIBarButtonItem._didTap(sender:))
			objc_setAssociatedObject(self, &didTapAssociativeKey, newValue, .OBJC_ASSOCIATION_RETAIN)
		}
	}
	
	func _didTap(sender: UIBarButtonItem) { didTap?.value() }
	
}

