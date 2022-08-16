//
//  UIView+loadNib.swift
//  MUtility
//
//  Created by MBP0003 on 8/9/21.
//

import Foundation

public extension UIView {
    @discardableResult
    func loadNib<T: UIView>() -> T? {
        guard let view = UINib(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
                .instantiate(withOwner: self, options: nil).first as? T else {
                    return nil
                }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)

        return view
    }

    func loadNib<T: UIView>(viewName name: T.Type) -> T {
        let identifier = String(describing: name)
        let bunde = Bundle(for: type(of: self))
        guard let view = bunde.loadNibNamed(identifier, owner: nil, options: nil)?.first as? T else {
            fatalError("Couldn't find View for \(String(describing: name))")
        }
        return view
    }
}
