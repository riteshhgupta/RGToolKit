//
//  UIPageViewController+Extension.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 02/12/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

public extension UIPageViewController {
	
	public var pageDelta: Int {
		guard let scrollView = scrollView else { return 0 }
		if scrollView.contentOffset.x < 375.0 { return -1 }
		else if scrollView.contentOffset.x > 375.0 { return 1 }
		return 0
	}
	public func show(viewController: UIViewController, inDirection direction: UIPageViewControllerNavigationDirection = .forward) {
		setViewControllers([viewController], direction: direction, animated: true, completion: nil)
	}
	public var scrollView: UIScrollView? {
		return view.subviews.filter { $0 is UIScrollView }.first as? UIScrollView
	}
}
