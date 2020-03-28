//
//  StringExtension.swift
//  Pods
//
//  Created by Don.shen on 2020/3/28.
//

import Foundation
import SwifterSwift

extension String {
    
    /// if  " "、"\t\r\n" 、 "\u{00a0}" 、 "\u{2002}" 、 "\u{2003}"
    /// https://useyourloaf.com/blog/empty-strings-in-swift/
    public var isBlank: Bool{
        return allSatisfy({$0.isWhitespace})
    }
    
    public func removeAllWhiteSpaceAndNewLines() -> String{
        var res = self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        res = res.replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
        return res
    }
    
    public func firstCharacterOfChinese() -> String{
        let str = NSMutableString(string: self) as CFMutableString
        var res = ""
        if CFStringTransform(str, nil, kCFStringTransformMandarinLatin, false){
            res = str as String
            if CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false){
                res = str as String
                let pinYin = res.capitalized as NSString
                res = pinYin.substring(to: 1)
            }
        }
        return res
    }
    
    public func stringByRemovingEmoji() -> String {
        return String(self.filter { !$0.isEmoji})
    }
    public var charactersArray: [Character] {
        return Array(self)
    }
}
extension Optional where Wrapped == String{
    public var isBlank : Bool{
        return self?.isBlank ?? true
    }
}
