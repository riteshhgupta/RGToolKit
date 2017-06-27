//
//  Date+Extension.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 04/02/17.
//  Copyright © 2017 Ritesh Gupta. All rights reserved.
//

import Foundation

public extension Date {
	
	public func without(_ components: [Calendar.Component]) -> Date {
		let calendar = Calendar.current
		let rawComponents: [Calendar.Component] = [.year, .month, .day, .hour, .minute]
		let filteredComponents = Set(rawComponents.filter { !components.contains($0) })
		let dateComponents = calendar.dateComponents(filteredComponents, from: self)
		return calendar.date(from: dateComponents) ?? self
	}
}
