//
//  UIAlertController+Extension.swift
//  ToolKit
//
//  Created by Ritesh Gupta on 14/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

public typealias AlertControllerHandler = AnyType<(UIAlertAction) -> Void>

public extension UIAlertController {
	
	public struct Item {
		let title: String
		let style: UIAlertActionStyle
	}
	
	fileprivate func add(
		items: [Item],
		completion: AlertControllerHandler? = nil) -> Self
	{
		let _ = items
			.map { item in
				UIAlertAction(title: item.title, style: item.style, handler: { action in
					completion?.value(action)
				})}
			.map { addAction($0) }
		
		return self
	}
	
	public func add(
		titles: [String],
		ofStyle style: UIAlertActionStyle = .default,
		completion: AlertControllerHandler? = nil) -> Self
	{
		let _items = titles.map { UIAlertController.Item(title: $0, style: style)  }
		return add(items: _items, completion: completion)
	}

}
