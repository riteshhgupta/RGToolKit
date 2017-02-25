//
//  Extension.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 26/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

public extension Collection where Iterator.Element == String {
	
	public func combineSeparatedBy(_ character: String) -> String {
		let combiner: (String, String) -> String = {
			$0 + $1 + character
		}
		var combined = reduce("", combiner)
		combined.remove(at: combined.endIndex)
		return combined
	}
}

public extension Collection where Iterator.Element: Equatable {
	
	public func after(_ element: Iterator.Element) -> Iterator.Element? {
		guard let idx = index(of: element), index(after: idx) < endIndex else { return nil }
		let nextIdx = index(after: idx)
		return self[nextIdx]
	}
	
	public func before(_ element: Iterator.Element) -> Iterator.Element? {
		guard let idx = index(of: element), index(before: idx) >= startIndex else { return nil }
		let previousIdx = index(idx, offsetBy: -1)
		return self[previousIdx]
	}
	
	public func index(before idx: Index) -> Index {
		return index(idx, offsetBy: -1)
	}
}

public extension Array  {
	
	// it removes the first element that matches the handler condition on the array itself
	@discardableResult
	public mutating func remove(_ handler: (Element) -> Bool) -> Element? {
		guard let idx = index(where: handler) else { return nil }
		let item = self[idx]
		remove(at: idx)
		return item
	}
	
	// it removes the first element that matches the handler condition & returns a new array
	public func removed(_ handler: (Element) -> Bool) -> Array {
		var items = self
		items.remove(handler)
		return items
	}
}

public extension Array {
	
	// it removes all the elements that matches the handler condition on the array itself
	public mutating func removeRecursively(_ handler: (Element) -> Bool) {
		guard let idx = index(where: handler) else { return }
		remove(at: idx)
		removeRecursively(handler)
	}
	
	// it removes all the elements that matches the handler condition & returns a new array
	public func removedRecursively(_ handler: (Element) -> Bool) -> Array {
		var items = self
		items.removeRecursively(handler)
		return items
	}
}

public extension Array  {
	
	public func appended(_ items: Array) -> Array {
		var newItems = self
		newItems.append(contentsOf: items)
		return newItems
	}
	
	public func firstFound(_ condition: (Element) -> Bool) -> Element? {
		return filter(condition).first
	}
}
