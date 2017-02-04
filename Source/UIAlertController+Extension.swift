//
//  UIAlertController+Extension.swift
//  ToolKit
//
//  Created by Ritesh Gupta on 14/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

public extension UIAlertController {
	
	public typealias Item = (String, UIAlertActionStyle)
	
	@discardableResult public func add(
		items: [Item],
		completion: Closure<UIAlertAction, Void>? = nil) -> Self
	{
		let _ = items
			.map { item in
				UIAlertAction(title: item.0, style: item.1, handler: { action in
					completion?(action)
				})}
			.map { addAction($0) }
		return self
	}
	
	@discardableResult public func add(
		titles: [String],
		cancelTitle: String? = nil,
		ofStyle style: UIAlertActionStyle = .default,
		completion: Closure<UIAlertAction, Void>? = nil) -> Self
	{
		var _items = titles.map { ($0, style) }
		if let title = cancelTitle {
			_items.append( (title, .cancel) )
		}
		return add(items: _items, completion: completion)
	}
}
