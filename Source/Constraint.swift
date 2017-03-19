//
//  Constraint.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 03/12/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit


public enum Constraint: Equatable {
	
	public typealias Handler = ([(Constraint, NSLayoutConstraint)]) -> Void
	
	case Top(Int, String?)
	case Bottom(Int, String?)
	case Left(Int, String?)
	case Right(Int, String?)
	case Width(Int)
	case Height(Int)
	case CenterX(String)
	case CenterY(String)
	
	func visualFormat(viewName: String) -> String {
		switch self {
		case .Top(let padding, let sibling):
			if let sibling = sibling {
				return "V:" + "|-(==0@1)-[\(sibling)]-\(padding)-" + "[\(viewName)]"
			}
			return "V:" + "|-\(padding)-" + "[\(viewName)]"
		case .Bottom(let padding, let sibling):
			let paddingString = "-(" + "\(padding)" + ")-"
			if let sibling = sibling {
				return "V:" + "[\(viewName)]" + paddingString + "[\(sibling)]-(==0@1)-|"
			}
			return "V:" + "[\(viewName)]" + paddingString + "|"
		case .Left(let padding, let sibling):
			if let sibling = sibling {
				return "H:" + "|-(==0@1)-[\(sibling)]-\(padding)-" + "[\(viewName)]"
			}
			return "H:" + "|-\(padding)-" + "[\(viewName)]"
		case .Right(let padding, let sibling):
			if let sibling = sibling {
				return "H:" + "[\(viewName)]" + "-\(padding)-" + "[\(sibling)]-(==0@1)-|"
			}
			return "H:" + "[\(viewName)]" + "-\(padding)-|"
		case .Width(let value):
			return "H:[\(viewName)(\(value))]"
		case .Height(let value):
			return "V:[\(viewName)(\(value))]"
		case .CenterX(let superView):
			return "H:[\(superView)]-(<=1)-[\(viewName)]"
		case .CenterY(let superView):
			return "V:[\(superView)]-(<=1)-[\(viewName)]"
		}
	}
	
	var options: NSLayoutFormatOptions {
		switch self {
		case .CenterY: return .alignAllCenterX
		case .CenterX: return .alignAllCenterY
		default: return []
		}
	}
	
	public static func == (lhs: Constraint, rhs: Constraint) -> Bool {
		switch (lhs, rhs) {
		default:
			return false
		}
	}
}
