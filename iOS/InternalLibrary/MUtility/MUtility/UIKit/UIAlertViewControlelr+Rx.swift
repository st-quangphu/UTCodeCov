//
//  UIAlertViewControlelr+Rx.swift
//  MAUtility
//
//  Created by MBP0003 on 8/13/21.
//

import Foundation
import UIKit

public protocol AlertActionType {
    associatedtype ResultType

    var title: String? { get }
    var style: UIAlertAction.Style { get }
    var result: ResultType { get }
}

extension UIViewController {
    public static func presentAlert<Action: AlertActionType>(
        viewController: UIViewController,
        title: String,
        message: String,
        preferredStyle: UIAlertController.Style = .alert,
        animated: Bool = true,
        actions: [Action],
        handler: ((Action) -> Void)?
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        actions
            .map { action in
                UIAlertAction(
                    title: action.title,
                    style: action.style,
                    handler: { _ in
                        handler?(action)
                    }
                )
            }
            .forEach(alertController.addAction)
        viewController.present(alertController, animated: animated, completion: nil)
    }
}
