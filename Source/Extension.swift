//
//  Extension.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 26/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation

extension Collection where Iterator.Element: Equatable {
	
	func after(_ element: Iterator.Element) -> Iterator.Element? {
		guard let idx = index(of: element), index(after: idx) < endIndex else { return nil }
		let nextIdx = index(after: idx)
		return self[nextIdx]
	}
	
	func before(_ element: Iterator.Element) -> Iterator.Element? {
		guard let idx = index(of: element), index(idx, offsetBy: -1) >= startIndex else { return nil }
		let previousIdx = index(idx, offsetBy: -1)
		return self[previousIdx]
	}
}
