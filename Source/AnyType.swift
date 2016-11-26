//
//  AnyType.swift
//  ToolKit
//
//  Created by Ritesh Gupta on 14/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation

open class AnyType<T> {
	
	open let value: T
	
	public init(_ value: T) {
		self.value = value
	}
}
