//
//  UIKitExtension.swift
//  SwiftWalle
//
//  Created by shen on 2022/3/29.
//

import UIKit
// Protocol ReuseIdentifiable
protocol ReuseIdentifiables {
    static func reuseIdentifier() -> String
}
extension ReuseIdentifiables {
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReuseIdentifiables {}

extension UICollectionReusableView: ReuseIdentifiables {}
// UIControl Action
class ClosureSleeve {
    let closure: () -> ()
    init(attachTo: AnyObject, closure: @escaping () -> ()) {
        self.closure = closure
        objc_setAssociatedObject(attachTo, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
    }
    @objc func invoke() {
        closure()
    }
}
extension UIControl{
    func addAction(for controlEvents: UIControl.Event = .primaryActionTriggered, action: @escaping () -> ()) {
        let sleeve = ClosureSleeve(attachTo: self, closure: action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
    }
}

// MARK: - UIView Extension
extension UIView {
    /// 同时添加cornerRadisu和Shadow
    ///  ⚠️: 如果覆写了  `draw(_ rect: CGRect)`方法，以下方法失效
    /// - Parameters:
    ///   - radius: radius description
    ///   - shadowColor: shadowColor description
    ///   - shadowOpacity: shadowOpacity description
    ///   - shadowOffset: shadowOffset description
    ///   - shadowRadius: shadowRadius description
    func addRadiusAndShadow(radius: CGFloat = 0.0, shadowColor: UIColor = .clear, shadowOpacity: Float = 0.5, shadowOffset: CGSize = .zero, shadowRadius: CGFloat = 1.0) {
        self.layer.cornerRadius = radius
        self.layer.shadowPath =
              UIBezierPath(roundedRect: self.bounds,
              cornerRadius: radius).cgPath
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
    }
    
    /// 同时添加边框，指定圆角
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    ///   - cornerRadius: 圆角大小
    ///   - cornerRect: 圆角方向
    @objc func addBorderCornerMask(borderWidth: CGFloat = 1.0, borderColor: UIColor = UIColor.darkGray, cornerRadius: CGFloat, cornerRect: UIRectCorner) {
        self.layer.sublayers?.filter({$0 is CAShapeLayer}).last?.removeFromSuperlayer()
        
        let maskLayer = CAShapeLayer()
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: cornerRect, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        maskLayer.path = maskPath
        self.layer.mask = maskLayer
        maskLayer.strokeColor = borderColor.cgColor
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskPath
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = self.bounds
        self.layer.addSublayer(borderLayer)
    }
    
    /// 添加和自身高度等高的半圆角
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    ///   - cornerRect: 圆角方向（不能选择allCorners）
    @objc func addHalfCorner(borderWidth: CGFloat = 0.0, borderColor: UIColor = UIColor.darkGray, cornerRect: UIRectCorner) {
        assert(cornerRect != .allCorners)
        self.layer.sublayers?.filter({$0 is CAShapeLayer}).last?.removeFromSuperlayer()
        let maskLayer = CAShapeLayer()
        let bezierPath = UIBezierPath()
        if cornerRect == .bottomLeft {
            bezierPath.addArc(withCenter: CGPoint(x: bounds.size.height, y: 0), radius: bounds.size.height, startAngle: CGFloat(-Double.pi), endAngle: CGFloat(Double.pi / 2), clockwise: false)
            bezierPath.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
            bezierPath.addLine(to: CGPoint(x: bounds.size.width, y: 0))
            bezierPath.addLine(to: .zero)
        } else if cornerRect == .bottomRight {
            bezierPath.move(to: CGPoint(x: bounds.size.width, y: 0))
            bezierPath.addArc(withCenter: CGPoint(x: bounds.size.width - bounds.size.height, y: 0), radius: bounds.size.height, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: true)
            bezierPath.addLine(to: CGPoint(x: 0, y: bounds.size.height))
            bezierPath.addLine(to: .zero)
        } else if cornerRect == .topLeft || cornerRect == .topRight {
            // 用到的时候再写
        }
        bezierPath.stroke()
        maskLayer.path = bezierPath.cgPath
        self.layer.mask = maskLayer
        maskLayer.strokeColor = borderColor.cgColor
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = bezierPath.cgPath
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = self.bounds
        self.layer.addSublayer(borderLayer)
    }
    /// 移除边框
    @objc func removeBorderCornerMask() {
        self.layer.sublayers?.filter({$0 is CAShapeLayer}).last?.removeFromSuperlayer()
    }
    /// 同时添加圆角和阴影
    /// - Parameters:
    ///   - shadowColor: shadowColor
    ///   - offSet: offSet
    ///   - opacity: opacity
    ///   - shadowRadius: shadowRadius
    ///   - cornerRadius: cornerRadius
    ///   - corners: corners
    ///   - fillColor: fillColor
    @objc func addShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner, fillColor: UIColor = .white) {
        if let subLayers = self.layer.sublayers {
            for sublayer in subLayers where sublayer is CAShapeLayer{
                sublayer.removeFromSuperlayer()
                break
            }
        }
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
        shadowLayer.path = cgPath //2
        shadowLayer.fillColor = fillColor.cgColor //3
        shadowLayer.shadowColor = shadowColor.cgColor //4
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet //5
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    public var boundsCenter: CGPoint {
        return CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
    }
}
