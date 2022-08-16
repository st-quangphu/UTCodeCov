//
//  ListHomeView.swift
//  WindyDev
//
//  Created by Rin Sang on 08/08/2022.
//

import UIKit
import MUIComponents
import MModels

final class ListHomeView: ParentView {

    @IBOutlet private weak var tableView: UITableView!

    var viewModel: ListHomeViewModelType?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configTableView()
    }

    convenience init(viewModel: ListHomeViewModelType) {
        self.init(frame: .zero)
        self.viewModel = viewModel
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     func configTableView() {
        tableView.register(UINib(nibName: "ListHomeCell", bundle: nil), forCellReuseIdentifier: "ListHomeCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: UITableViewDataSource
extension ListHomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      viewModel?.numberOfItems(in: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListHomeCell", for: indexPath) as? ListHomeCell,
            let viewModel = viewModel else { return UITableViewCell() }
      let listHomeCellData = viewModel.cellForItem(at: indexPath, cellData: ListHomeCellData.self)
      cell.loadData(viewData: listHomeCellData)
      return cell
    }
}

// MARK: UITableViewDelegate
extension ListHomeView: UITableViewDelegate {
}
