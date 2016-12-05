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

public protocol Describable	{
	var typeName: String { get }
	static var typeName: String { get }
}

public extension Describable {
	var typeName: String {
		return String(describing: self)
	}
	static var typeName: String {
		return String(describing: self)
	}
}

public extension Describable where Self: NSObjectProtocol {
	var typeName: String {
		let type = type(of: self)
		return String(describing: type)
	}
}

extension NSObject: Describable {}

public protocol Nibable {
	var nib: UINib { get }
	static var nib: UINib { get }
}
