//
//  UIView+Extension.swift
//  SwiftWalle
//
//  Created by Don.shen on 2020/5/25.
//

import UIKit

extension UIView {
    
    public func firstResponderController() -> UIViewController? {
        return reverseResponderChainForUIViewController()
    }
    public func reverseResponderChainForUIViewController() -> UIViewController? {
        let _nextResponder = self.next
        if _nextResponder is UIViewController {
            return _nextResponder as? UIViewController
        } else if _nextResponder is UIView {
            return (_nextResponder as! UIView).reverseResponderChainForUIViewController()
        } else {
            return nil
        }
    }
}
