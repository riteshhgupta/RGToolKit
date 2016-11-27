//
//  UICollectionView+Extension.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 27/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionView {

	public func dequeueReusableGenericCell<T: UICollectionViewCell>(withReuseIdentifier identifier: String, for indexpath: IndexPath) -> T {
		return dequeueReusableCell(withReuseIdentifier: identifier, for: indexpath) as! T
	}
}
