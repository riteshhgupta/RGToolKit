//
//  Protocols.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 26/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

typealias TapHandler = AnyType<() -> Void>

protocol Tapable {
	
	var didTap: TapHandler? { get set }
}

protocol ContentViewProvider {
	
	var contentView: UIView? { get set }
}
