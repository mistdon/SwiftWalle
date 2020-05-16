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
