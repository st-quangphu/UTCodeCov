//
//  HistoryCell.swift
//  WindyDev
//
//  Created by Rin Sang on 19/07/2022.
//

import UIKit
import MUIComponents
import SnapKit

final class HistoryCell: UITableViewCell {

    @IBOutlet private weak var stackView: UIStackView!

    let dumyData: [String] = ["Mumbai", "Pure"]

    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView() {
        selectionStyle = .none
        configStackView()
    }

    private func configStackView() {
        stackView.removeAllArrangedSubviews()
        dumyData.forEach({ text in
            let historySearchView = HistorySearchView(string: text)
            historySearchView.delegate = self
            stackView.addArrangedSubview(historySearchView)
        })
    }
}

extension HistoryCell: HistorySearchViewDelegate {
    func view(_ view: HistorySearchView, needPerform action: HistorySearchView.Action) {
        switch action {
        case .click(let text):
                print(text ?? "")
        }
    }
}
