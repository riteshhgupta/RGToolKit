//
//  Result.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 13/02/17.
//  Copyright © 2017 Ritesh Gupta. All rights reserved.
//

import Foundation

public enum Result<Value, _Error: Error> {
	
	case value(Value)
	case error(_Error)
}
