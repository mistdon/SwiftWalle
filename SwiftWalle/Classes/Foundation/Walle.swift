//
//  Walle.swift
//  Pods-SwiftWalle_Example
//
//  Created by Don.shen on 2020/4/9.
//

import Foundation

/// Synchronzed event like @synchronized() in Objective-C
/// - Parameters:
///   - lock: any need to be locked
///   - closure: closure description
/// - Returns: description
func synchronized(_ lock: Any, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}
