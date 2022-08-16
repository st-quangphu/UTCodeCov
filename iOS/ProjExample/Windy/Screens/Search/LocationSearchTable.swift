//
//  LocationSearchTable.swift
//  Windy
//
//  Created by Long Vo M. on 7/15/22.
//

import Foundation
import UIKit
import MapKit
import SnapKit
import MUtility

protocol LocationSearchTableDelegate: AnyObject {
    func viewController(
        _ vc: LocationSearchTable,
        placemark: MKMapItem
    )
}

class LocationSearchTable: UIView {
    private var matchingItems = [MKMapItem]()
    weak var delegate: LocationSearchTableDelegate?
    private lazy var tableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.tableFooterView = UIView()
        tb.backgroundColor = .clear
        return tb
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }

    func updateTableView(listItems: [MKMapItem]) {
        matchingItems = listItems
        tableView.reloadData()
    }
}

extension LocationSearchTable: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        matchingItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCellType: UITableViewCell.self, for: indexPath)
        if let selectedItem = matchingItems[safe: indexPath.row]?.placemark {
            cell.textLabel?.text = selectedItem.name
            cell.detailTextLabel?.text = "\(selectedItem.coordinate.latitude) \(selectedItem.coordinate.longitude)"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row]
        delegate?.viewController(self, placemark: selectedItem)
    }
}

extension LocationSearchTable: SubviewsSetupable {
    func setupSubviews() {
        setupTableView()
        tableView.register(UITableViewCell.self)
        tableView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
}
