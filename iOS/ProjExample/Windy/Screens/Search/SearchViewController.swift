//
//  SearchViewController.swift
//  Windy
//
//  Created by Rin Sang on 18/07/2022.
//

import UIKit
import SnapKit
import MapKit
import MUtility
import MUIComponents

final class SearchViewController: UIViewController, SubviewsSetupable {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var tableView: UITableView!

    private lazy var locationSearchTable = LocationSearchTable()

    private let viewModel: SearchViewModelType
    private var navigator: SearchNavigator.Type

    init(
        navigator: SearchNavigator.Type,
        viewModel: SearchViewModelType
    ) {
        self.navigator = navigator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTextField.becomeFirstResponder()
    }

    func setupSubviews() {
        configTableView()
        configStackView()
        configSuggestLocationList()
    }

    private func configTableView() {
        tableView.register(UINib(nibName: "LocationCell", bundle: nil), forCellReuseIdentifier: "LocationCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func configStackView() {
        stackView.removeAllArrangedSubviews()
        let historySearch = viewModel.getHistorySearch()
        historySearch.forEach({ text in
            let historySearchView = HistorySearchView(string: text)
            historySearchView.delegate = self
            stackView.addArrangedSubview(historySearchView)
        })
    }

    private func configSuggestLocationList() {
        locationSearchTable.delegate = self
        view.addSubview(locationSearchTable)

        locationSearchTable.snp.makeConstraints { maker in
            maker.top.equalTo(searchView.snp.bottom)
            maker.leading.trailing.equalTo(searchView)
            maker.height.equalTo(200)
        }
        locationSearchTable.isHidden = true
    }

    @IBAction private func backButtonTouchUpInside(_ sender: Any) {
        _ = navigator.navigate(to: .home, from: self)
    }

    @IBAction private func searchDidChange(_ sender: UITextField) {
        let locationName = sender.text ?? ""
        searchLocation(keysearch: locationName)
    }

    private func searchLocation(keysearch: String) {
        viewModel.searchLocation(by: keysearch, completion: { [weak self] result in
            switch result {
            case .success(let list):
                self?.locationSearchTable.isHidden = list.isEmpty
                self?.locationSearchTable.updateTableView(listItems: list)

            case .failure:
                break
            }
        })
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as? LocationCell
        let vm = viewModel.cellForItem(at: indexPath, cellData: LocationCellViewData.self)
        cell?.loadData(viewData: vm)
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let placemark = viewModel.getMapkitItem(at: indexPath) {
            _ = navigator.navigate(to: .weatherDetail(place: placemark), from: self)
        }
    }
}

// MARK: - LocationSearchTableDelegate
extension SearchViewController: LocationSearchTableDelegate {
    func viewController(_ vc: LocationSearchTable, placemark: MKMapItem) {
        viewModel.saveHistorySearch(keySearch: placemark.name ?? "")
        configStackView()
        locationSearchTable.isHidden = true
        viewModel.getWeather(place: placemark) { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - HistorySearchViewDelegate
extension SearchViewController: HistorySearchViewDelegate {
    func view(_ view: HistorySearchView, needPerform action: HistorySearchView.Action) {
        switch action {
        case .click(let text):
            searchTextField.text = text
            searchLocation(keysearch: text ?? "")
        }
    }
}
