//
//  ContainerView.swift
//  NoStoryboards
//
//  Created by Ritesh Gupta on 12/11/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

private var containerViewAssociationKey = "containerViewAssociationKey"

public class ContainerView: UIView {}

extension ContainerView: ContentViewProvider {
	
	public var contentView: UIView? {
		get { return objc_getAssociatedObject(self, &containerViewAssociationKey) as? UIView }
		set {
			objc_setAssociatedObject(self, &containerViewAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
			add(subview: newValue!, viewsDict: ["contentView": newValue!])
		}
	}
	
}
