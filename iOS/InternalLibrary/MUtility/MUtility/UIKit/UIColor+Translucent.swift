//
//  UIColor+Translucent.swift
//  MAUtility
//
//  Created by MBP0003 on 8/13/21.
//

import UIKit

public extension UIColor {
    var translucent: UIColor {
        withAlphaComponent(0.96)
    }

    var alertTranslucent: UIColor {
        withAlphaComponent(0.86)
    }
}
