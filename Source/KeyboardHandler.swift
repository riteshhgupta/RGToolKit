//
//  KeyboardHandler.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 25/02/17.
//  Copyright © 2017 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

public protocol KeyboardHandler {
	
	var bottomConstraint: NSLayoutConstraint { get }
	var bottomConstraintDefaultValue: CGFloat { get }
}

public extension KeyboardHandler {
	
	var bottomConstraintDefaultValue: CGFloat {
		return 0.0
	}
}

public extension KeyboardHandler where Self: UIViewController {
	
	public func registerForKeyboardNotifications() {
		NotificationCenter.default.addObserver(
			forName: .UIKeyboardDidShow,
			object: nil,
			queue: nil) { [weak self] (notification) in
				guard let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
				self.then {
					$0.bottomConstraint.constant = keyboardSize.height
					$0.view.layoutIfNeeded()
				}
		}
		NotificationCenter.default.addObserver(
			forName: .UIKeyboardWillHide,
			object: nil,
			queue: nil) { [weak self] _ in
				self.then {
					$0.bottomConstraint.constant = $0.bottomConstraintDefaultValue
					$0.view.layoutIfNeeded()
				}
		}
	}
	public func removeKeyboardNotifications() {
		NotificationCenter.default.removeObserver(
			self,
			name: .UIKeyboardWillShow,
			object: nil
		)
		NotificationCenter.default.removeObserver(
			self,
			name: .UIKeyboardWillHide,
			object: nil
		)
	}
}
