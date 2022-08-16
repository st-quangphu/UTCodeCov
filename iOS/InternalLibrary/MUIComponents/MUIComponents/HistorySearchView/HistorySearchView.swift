//
//  HistorySearchView.swift
//  MUIComponents
//
//  Created by Rin Sang on 20/07/2022.
//

import Foundation
import UIKit
import SnapKit

public protocol HistorySearchViewDelegate: AnyObject {
    func view(_ view: HistorySearchView, needPerform action: HistorySearchView.Action )
}

public class HistorySearchView: UIView {

    public enum Action {
        case click(String?)
    }

    public weak var delegate: HistorySearchViewDelegate?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    public init(string: String?) {
        super.init(frame: CGRect.zero)
        configUI()
        titleLabel.text = string
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        backgroundColor = UIColor(red: 0.992, green: 0.989, blue: 0.989, alpha: 1)
        addGestureRecognizer(tapGesture)
        layer.cornerRadius = 7

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(18)
            $0.trailing.equalTo(-18)
        }
    }

    @objc
    private func tap() {
        delegate?.view(self, needPerform: .click(titleLabel.text))
    }
}
