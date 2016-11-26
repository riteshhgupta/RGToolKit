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
