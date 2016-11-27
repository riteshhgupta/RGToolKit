//
//  UIViewController+Extension.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 26/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

// functionality related to navigation buttons

public extension UIViewController {
	
	public func addRightNavbarItems(_ barButtonItems: [UIBarButtonItem]) {
		navigationItem.rightBarButtonItems = barButtonItems
	}
	public func addLeftNavbarItems(_ barButtonItems: [UIBarButtonItem]) {
		navigationItem.leftBarButtonItems = barButtonItems
	}
	public func addRightNavbarItem(_ barButtonItem: UIBarButtonItem) {
		addRightNavbarItems([barButtonItem])
	}
	public func addLeftNavbarItem(_ barButtonItem: UIBarButtonItem) {
		addLeftNavbarItems([barButtonItem])
	}
}

// functionality related to Container View

public extension UIViewController {
	
	public func add(childVC: UIViewController, embedInContainerView containerView: ContainerView) {
		containerView.contentView = childVC.view
		
		childVC.willMove(toParentViewController: self)
		addChildViewController(childVC)
		childVC.didMove(toParentViewController: self)
	}
}
