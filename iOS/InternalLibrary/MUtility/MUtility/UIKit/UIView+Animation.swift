//
//  UIView + Animation.swift
//  MUtility
//
//  Created by MBP0003 on 8/9/21.
//

import Foundation
import UIKit

public extension UIView {
    func fadeIn(
        duration: TimeInterval = 0.3,
        delay: TimeInterval = 0.0,
        completion: @escaping ((Bool) -> Void) = { (_: Bool) -> Void in }
    ) {
        self.alpha = 0.0

        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: [.curveEaseOut, .transitionFlipFromBottom],
            animations: {
                self.isHidden = false
                self.alpha = 1.0
            },
            completion: completion
        )
    }

    func fadeOut(
        duration: TimeInterval = 0.3,
        delay: TimeInterval = 0.0,
        completion: @escaping (Bool) -> Void = { (_: Bool) -> Void in }
    ) {
        self.alpha = 1.0

        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: [.curveEaseOut, .transitionFlipFromTop],
            animations: {
                self.isHidden = true
                self.alpha = 0.0
            },
            completion: completion
        )
    }
}
