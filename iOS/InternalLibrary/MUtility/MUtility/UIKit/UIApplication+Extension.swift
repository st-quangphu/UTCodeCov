//
//  UIApplication+Extension.swift
//  MAUtility
//
//  Created by MBP0003 on 8/6/21.
//

import UIKit

public extension UIApplication {
    static var rootViewController: UIViewController? {
        UIApplication.shared.delegate?.window??.rootViewController
    }

    static func topViewController(
        baseViewController: UIViewController? = UIApplication.rootViewController
    ) -> UIViewController? {
        if let navigationController = baseViewController as? UINavigationController {
            return topViewController(baseViewController: navigationController.visibleViewController)
        } else
        if let tabBarController = baseViewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return topViewController(baseViewController: selectedViewController)
        } else
        if let presentedViewController = baseViewController?.presentedViewController {
            return topViewController(baseViewController: presentedViewController)
        }
        return baseViewController
    }

    static func isSelfOrAnyPresentedViewControllerKindOf<T: UIViewController>(
        _ classType: T.Type,
        baseViewController: UIViewController? = UIApplication.rootViewController
    ) -> Bool {
        var isPresented = false

        if baseViewController is T {
            isPresented = true
        } else if let visibleViewController = (baseViewController as? UINavigationController)?.visibleViewController {
            // NavigationController
            isPresented = isSelfOrAnyPresentedViewControllerKindOf(classType, baseViewController: visibleViewController)
        } else if let selectedViewController = (baseViewController as? UITabBarController)?.selectedViewController {
            // TabBarController
            isPresented = isSelfOrAnyPresentedViewControllerKindOf(
                classType,
                baseViewController: selectedViewController)
        } else if let presentedViewController = baseViewController?.presentedViewController {
            // Neither a NavigationController nor a TabBarController
            isPresented = isSelfOrAnyPresentedViewControllerKindOf(
                classType,
                baseViewController: presentedViewController)
        }

        Log.debug("Is \(classType) presented? \(isPresented)")
        return isPresented
    }
}
