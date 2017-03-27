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
	
	var constraint: NSLayoutConstraint { get }
	var dismissValue: CGFloat { get }
	var initialValue: CGFloat { get }
}

public extension KeyboardHandler {
	
	var bottomConstraintDefaultValue: CGFloat {
		return 0.0
	}
}

public extension KeyboardHandler where Self: UIViewController {
	
	public func registerForKeyboardNotifications() {
		NotificationCenter.default.addObserver(
			forName: .UIKeyboardWillShow,
			object: nil,
			queue: nil) { [weak self] (notification) in
				guard let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
				self.then {
					$0.constraint.constant = keyboardSize.height - $0.initialValue
					$0.view.layoutIfNeeded()
				}
		}
		NotificationCenter.default.addObserver(
			forName: .UIKeyboardWillHide,
			object: nil,
			queue: nil) { [weak self] _ in
				self.then {
					$0.constraint.constant = $0.dismissValue
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
