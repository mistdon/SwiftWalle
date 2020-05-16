//
//  MemoryAddress.swift
//  Pods
//
//  Created by Don.shen on 2020/4/1.
//

import Foundation

/// https://gist.github.com/nyg/b6a80bf79e72599230c312c69e963e60

/// Print memory address of class and structs
/// class:   print(classInstanceAddress)  // and not &classInstance
/// struct:  print(structInstanceAddress) // use &structInstanceAddress

struct MemoryAddress<T>: CustomStringConvertible {

    let intValue: Int

    var description: String {
        let length = 2 + 2 * MemoryLayout<UnsafeRawPointer>.size
        return String(format: "%0\(length)p", intValue)
    }
    // for structures
    init(of structPointer: UnsafePointer<T>) {
        intValue = Int(bitPattern: structPointer)
    }
}
extension MemoryAddress where T: AnyObject {
    // for classes
    init(of classInstance: T) {
        intValue = unsafeBitCast(classInstance, to: Int.self)
        // or      Int(bitPattern: Unmanaged<T>.passUnretained(classInstance).toOpaque())
    }
}
