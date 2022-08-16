//
//  UIViewController+showActivityIndicator.swift
//  MUtility
//
//  Created by MBP0003 on 8/9/21.
//

import UIKit
import SnapKit
import Foundation

var indicatorParentViewTag = 123

public extension UIViewController {

    func showHUD(rootWindow: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) {
        let controller = rootWindow ?? self
        guard controller.view.subviews.contains(where: { $0.tag == indicatorParentViewTag }) != true else { return }
        let containerView = UIView()
        containerView.tag = indicatorParentViewTag
        containerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3984109269)
        controller.view.addSubview(containerView)
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        containerView.snp.makeConstraints { maker in
            maker.top.leading.trailing.bottom.equalToSuperview()
        }
        containerView.addSubview(indicator)
        indicator.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
        indicator.startAnimating()
    }

    func hideHUD(rootWindow: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) {
        let controller = rootWindow ?? self
        controller.view.subviews.forEach { view in
            if view.tag == indicatorParentViewTag {
                view.removeFromSuperview()
            }
        }
    }

    /// Check if HUD is diplaying
    /// - Parameter rootWindow: rootWindow
    /// - Returns: True if HUD is display, false if HUD is not display
    func isDiplaying(
        rootWindow: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController
    ) -> Bool {
        let controller = rootWindow ?? self
        let subviews = controller.view.subviews
        for index in 0..<subviews.count where subviews[index].tag == indicatorParentViewTag {
            return true
        }
        return false
    }
}
