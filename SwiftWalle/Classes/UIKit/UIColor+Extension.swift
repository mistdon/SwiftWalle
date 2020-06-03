//
//  UIColor+Extension.swift
//  Pods-SwiftWalle_Example
//
//  Created by Don.shen on 2020/3/28.
//

import UIKit
import Foundation
/**
 MissingHashMarkAsPrefix:   "Invalid RGB string, missing '#' as prefix"
 UnableToScanHexValue:      "Scan hex error"
 MismatchedHexStringLength: "Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8"
 */
public enum UIColorInputError : Error {
    case missingHashMarkAsPrefix,
         unableToScanHexValue,
         mismatchedHexStringLength
}

public extension UIColor {
    /// The shorthand three-digit hexadecimal representation of color.
    /// #RGB defines to the color #RRGGBB.
    /// - Parameters:
    ///   - hex3: Three-digit hexadecimal value.
    ///   - alpha: 0.0 - 1.0. The default is 1.0.
    convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue    = CGFloat( hex3 & 0x00F      ) / divisor

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// The shorthand four-digit hexadecimal representation of color with alpha.
    ///  #RGBA defines to the color #RRGGBBAA.
    /// - Parameter hex4: hex4 description
    convenience init(hex4: UInt16) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green   = CGFloat((hex4 & 0x0F00) >>  8) / divisor
        let blue    = CGFloat((hex4 & 0x00F0) >>  4) / divisor
        let alpha   = CGFloat( hex4 & 0x000F       ) / divisor

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// The six-digit hexadecimal representation of color of the form #RRGGBB.
    /// - Parameters:
    ///   - hex6: Six-digit hexadecimal value.
    convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.
    /// - Parameter hex8: Eight-digit hexadecimal value.
    convenience init(hex8: UInt32) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
        let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// Transfer Hex6 String to UIColor
    /// - Demo:
    ///   let color = UIColor(hex6: "#62CCB0 0.5")
    ///   let color = UIColor(hex6: "#62CCB0")
    convenience init(hex6_throws hex6: String) throws {
        guard hex6.hasPrefix("#") else {
            throw UIColorInputError.missingHashMarkAsPrefix
        }
        let r, g, b: CGFloat
        var a: CGFloat
        let start = hex6.index(hex6.startIndex, offsetBy: 1)
        var hexColor = String(hex6[start...])
        let hexArray = hexColor.components(separatedBy: " ")
        a = 1.0
        if hexArray.count == 2{
          hexColor = hexArray[0]
          let temp_alpha = Double(hexArray[1])
          if let temp_alpha = temp_alpha, temp_alpha >= 0, temp_alpha <= 1.0 {
              a = CGFloat(temp_alpha)
          }
        }
        if hexColor.count == 6 {
          let scanner = Scanner(string: hexColor)
          var hexNumber: UInt64 = 0
          if scanner.scanHexInt64(&hexNumber){
              r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
              g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
              b = CGFloat(hexNumber & 0x000000ff) / 255
              self.init(red: r, green: g, blue: b, alpha: a)
            }
        }
        throw UIColorInputError.mismatchedHexStringLength
    }
    
    convenience init(hex6: String, defaultColor: UIColor = UIColor.clear) {
        guard let color = try? UIColor(hex6_throws: hex6) else {
            self.init(cgColor: defaultColor.cgColor)
            return
        }
        self.init(cgColor: color.cgColor)
    }
    
    /// The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, throws error.
    /// - Parameter rgba: rggb String value.
    convenience init(rgba_throws rgba: String) throws {
        guard rgba.hasPrefix("#") else {
            throw UIColorInputError.missingHashMarkAsPrefix
        }
        let hexString: String = String(rgba[rgba.index(rgba.startIndex, offsetBy: 1)...])
        var hexValue:  UInt32 = 0
        
        guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
            throw UIColorInputError.unableToScanHexValue
        }
        switch (hexString.count) {
        case 3:
            self.init(hex3: UInt16(hexValue))
        case 4:
            self.init(hex4: UInt16(hexValue))
        case 6:
            self.init(hex6: hexValue)
        case 8:
            self.init(hex8: hexValue)
        default:
            throw UIColorInputError.mismatchedHexStringLength
        }
    }
    /// The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, fails to default color.
    /// - Parameters:
    ///   - rgba: String value.
    convenience init(rgba: String, defaultColor: UIColor = UIColor.clear) {
        guard let color = try? UIColor(rgba_throws: rgba) else {
            self.init(cgColor: defaultColor.cgColor)
            return
        }
        self.init(cgColor: color.cgColor)
    }
    
    /// Hex string of a UIColor instance.
    /// - Parameter includeAlpha: Whether the alpha should be included.
    func hexString(_ includeAlpha: Bool) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if (includeAlpha) {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
    
    /// Get r RGBA value
    /// - Returns: each value of RGBA
    func getRGBA() -> (CGFloat, CGFloat, CGFloat, CGFloat){
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r * 255.0, g * 255.0, b * 255.0, a)
    }
    override var description: String {
        return self.hexString(true)
    }
    
    override var debugDescription: String {
        return self.hexString(true)
    }
    static func random(hue: CGFloat = CGFloat.random(in: 0...1),
                       saturation: CGFloat = CGFloat.random(in: 0.5...1), // from 0.5 to 1.0 to stay away from white
                       brightness: CGFloat = CGFloat.random(in: 0.5...1), // from 0.5 to 1.0 to stay away from black
                       alpha: CGFloat = 1) -> UIColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
}
