//
//  ParentView.swift
//  WeatherApp
//
//  Created by Rin Sang on 14/07/2022.
//

import Foundation
import UIKit

open class ParentView: UIView {

    var xibName: String {
        String(describing: type(of: self))
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
        loadNib()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func loadNib() {
        var xib: String?
        if Bundle.main.path(forResource: xibName, ofType: "nib") != nil {
            xib = xibName
        }

        if let xib = xib, let view = Bundle.main.loadNibNamed(xib, owner: self)?.first as? UIView {
            addSubview(view)
            view.frame = bounds
            constrainToEdges(view)
        }
    }
}

extension UIView {
    func constrainToEdges(_ subview: UIView, insets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        subview.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        subview.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}
