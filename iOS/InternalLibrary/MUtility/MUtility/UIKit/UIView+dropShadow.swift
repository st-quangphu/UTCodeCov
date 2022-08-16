//
//  UIView+dropShadow.swift
//  MUtility
//
//  Created by MBP0003 on 8/9/21.
//

import UIKit

public extension UIView {
    func addDropShadow(color: UIColor, opacity: Float = 1, offSet: CGSize, radius: CGFloat = 0, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.layer.cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    func addInnerShadow(color: UIColor, opacity: Float = 1, offSet: CGSize, radius: CGFloat = 0) {
        let innerShadow = CALayer()
        innerShadow.frame = bounds
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: 0.5, dy: 0.5), cornerRadius: radius)
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius: radius).reversing()

        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true

        innerShadow.shadowColor = color.cgColor
        innerShadow.shadowOffset = offSet
        innerShadow.shadowOpacity = opacity
        innerShadow.shadowRadius = radius
        innerShadow.cornerRadius = self.layer.cornerRadius
        layer.addSublayer(innerShadow)
    }
}
