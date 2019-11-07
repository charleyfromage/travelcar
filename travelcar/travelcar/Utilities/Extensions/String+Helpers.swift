//
//  String+Helpers.swift
//  travelcar
//
//  Created by Fromage Charley on 07/11/2019.
//  Copyright © 2019 Voodoo Coding. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func attributedStringByHighlighting(_ subString: String?, with color: UIColor) -> NSAttributedString? {
        guard let subString = subString else { return NSAttributedString(string: self) }

        let attributedString = NSMutableAttributedString(string: self)

        let range = (self as NSString).range(of: subString, options: .caseInsensitive, range: NSRange(location: 0, length: self.count))

        if range.length > 0 {
            attributedString.addAttribute(NSAttributedString.Key.backgroundColor, value: color, range: range)
        }

        return attributedString
    }
}
