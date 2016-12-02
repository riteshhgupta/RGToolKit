//
//  Protocols.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 26/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

public typealias TapHandler = AnyType<() -> Void>

public protocol Tapable {
	
	var didTap: TapHandler? { get set }
}

public protocol ContentViewProvider {
	
	var contentView: UIView? { get set }
}

protocol Describable	{
	var typeName: String { get }
	static var typeName: String { get }
}

extension Describable {
	var typeName: String {
		return String(describing: self)
	}
	static var typeName: String {
		return String(describing: self)
	}
}

extension Describable where Self: NSObjectProtocol {
	var typeName: String {
		let type = type(of: self)
		return String(describing: type)
	}
}
