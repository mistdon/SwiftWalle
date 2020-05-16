//
//  NSAttributedString+Extension.swift
//  Pods-SwiftWalle_Example
//
//  Created by Don.shen on 2020/4/14.
//

import Foundation

extension NSAttributedString {
    // highlight substring in NSAttributedString
    func highlighing(_ substring: String, using color: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        attributedString.addAttribute(.foregroundColor, value: color, range: (self.string as NSString).range(of: substring))
        return attributedString
    }
}
