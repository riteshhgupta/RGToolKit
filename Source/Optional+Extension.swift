//
//  Optional+Extension.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 04/02/17.
//  Copyright © 2017 Ritesh Gupta. All rights reserved.
//

import Foundation

extension Optional {
	
	func then(_ handler: Closure<Wrapped, Void>) {
		switch self {
		case .none: break
		case .some(let value): handler(value)
		}
	}
}
