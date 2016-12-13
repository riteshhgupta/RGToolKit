//
//  String+Extension.swift
//  RGToolKit
//
//  Created by Ritesh Gupta on 06/12/16.
//  Copyright © 2016 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

public extension String {

	public func attributedWith(foregroundColor: UIColor? = nil, backgroundColor: UIColor? = nil, font: UIFont? = nil) -> NSAttributedString {
		var attributes: [String: Any] = [:]
		if let color = foregroundColor { attributes[NSForegroundColorAttributeName] = color }
		if let color = backgroundColor { attributes[NSBackgroundColorAttributeName] = color }
		if let font = font { attributes[NSFontAttributeName] = font }
		
		let attributedString = NSAttributedString(string: self, attributes: attributes)
		return attributedString
	}
	
	public func indexBefore(_ i: Int) -> Index {
		let elements = components(separatedBy: " ")
		var chars = 0
		(0...i).forEach { idx in
			chars += (elements[idx].characters.count + 1)
		}
		chars -= 1
		chars -= elements[i].characters.count
		
		let index = self.index(startIndex, offsetBy: chars, limitedBy: endIndex)
		return index ?? startIndex
	}
	
	public func indexAfter(_ i: Int) -> Index {
		let elements = components(separatedBy: " ")
		guard i < elements.count else { return endIndex }
		var chars = 0
		(0...i).forEach { idx in
			chars += (elements[idx].characters.count + 1)
		}
		let index = self.index(startIndex, offsetBy: chars, limitedBy: endIndex)
		return index ?? endIndex
	}
	
	public func textPerLine(forFitingSize size: CGSize, font: UIFont) -> [String] {
		let lines = linesCount(forFitingSize: size, font: font)
		
		let elements = components(separatedBy: " ")
		var wordIndex = 0
		var start = startIndex
		var end = indexAfter(wordIndex)
		var range = Range(uncheckedBounds: (start, end))
		var sentances: [String] = []
		
		(0..<lines).forEach { _ in
			range = Range(uncheckedBounds: (start, end))
			var subString = " " + substring(with: range)
			
			while subString.linesCount(forFitingSize: size, font: font) == 1 && wordIndex < elements.count {
				wordIndex += 1
				end = indexAfter(wordIndex)
				range = Range(uncheckedBounds: (start, end))
				subString = " " + substring(with: range) + " "
			}
			
			if wordIndex < elements.count {
				end = indexBefore(wordIndex)
			}
			range = Range(uncheckedBounds: (start, end))
			sentances.append(substring(with: range))
			
			if wordIndex < elements.count {
				start = end
				wordIndex += 1
				end = indexAfter(wordIndex)
			}
		}
		return sentances
	}
	
	public func linesCount(forFitingSize size: CGSize, font: UIFont) -> Int {
		let label = UILabel()
		label.numberOfLines = 0
		label.text = self
		label.font = font
		let fitingSize = label.sizeThatFits(size)
		let lines = Int(fitingSize.height/font.lineHeight)
		return lines
	}
}

