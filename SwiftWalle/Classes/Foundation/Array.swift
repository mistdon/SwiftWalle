//
//  Array.swift
//  SwiftWalle_Example
//
//  Created by Don.shen on 2020/4/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

extension Array {
    subscript(safe indexPath: IndexPath) -> Element? {
        self[indexPath.row]
    }
}

extension Array where Element: Comparable {
    /// 判断两个数组是否含有相同的元素，且顺序一致
    /// - Parameter other: 对比数组
    /// - Returns: 是否一致
    func containsSameOrderElements(as other: [Element]) -> Bool {
        return self.count == other.count && self == other
    }
    
    /// 判断两个数组是否含有相同的元素，忽略顺序
    /// - Parameter other: 对比数组
    /// - Returns: 是否一致
    func containsSameElements(as other: [Element]) -> Bool {
        return self.count == other.count && self == other
    }
}

extension Array where Element == String {
    
    /// 将字符串数组拼接成一个带分割符的字符串，过滤无效字符串
    ///
    ///      print(["1", "2", "3"].separateToString(separate: ","))
    ///      // 1,2,3
    ///      print(["1", "2", "", "3"].separateToString(separate: ","))
    ///      // 1,2,3
    ///      print(["1", "2", "3"].separateToString(separate: "+"))
    ///      // 1+2+3
    ///
    /// - Parameter separate: 分割符
    /// - Returns: 字符串
    func separateToString(separate: String) -> String {
        if self.count == 0 {
            return ""
        }
        let result = self.filter({$0.count > 0}).reduce("", { $0 + separate + $1}).dropFirst()
        return String(result)
    }
}
