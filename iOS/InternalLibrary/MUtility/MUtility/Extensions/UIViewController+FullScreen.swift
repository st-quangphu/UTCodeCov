//
//  UIViewController+FullScreen.swift
//  MAUtility
//
//  Created by MBP0003 on 8/13/21.
//

import Foundation

extension UIViewController {
    public func presentModally(
        _ viewControllerToPresent: UIViewController,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        if Platform.ios13 {
            viewControllerToPresent.modalPresentationStyle = .fullScreen
        }
        present(viewControllerToPresent, animated: animated, completion: completion)
    }
}
