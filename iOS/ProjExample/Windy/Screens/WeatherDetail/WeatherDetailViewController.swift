//
//  WeatherDetailViewController.swift
//  Windy
//
//  Created by Rin Sang on 19/07/2022.
//

import UIKit
import MResources
import MUtility

final class WeatherDetailViewController: UIViewController, SubviewsSetupable {

    // MARK: - Outlets
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var rainForecastView: RainForecastView!
    @IBOutlet private weak var weatherInfoView: WeatherInfoView!
    @IBOutlet private weak var locationNameLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var addToListButton: UIButton!
    @IBOutlet private weak var temputareLabel: UILabel!

    private var navigator: WeatherDetailNavigator.Type
    private var viewModel: WeatherDetailViewModelType
    private var refreshControl = UIRefreshControl()

    init(
        viewModel: WeatherDetailViewModelType,
        navigator: WeatherDetailNavigator.Type
    ) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        getWeather()
        handleEventsFromViewModel()
    }

    func setupSubviews() {
        updateAddButton()
        addPullToRefresh()
    }

    @IBAction private func backButtonTouchUpInside(_ sender: Any) {
        _ = navigator.navigate(to: .search, from: self)
    }

    @IBAction private func addToListButtonTouchUpInside(_ sender: Any) {
        viewModel.addToBookmark { [weak self] result in
            switch result {
            case .success:
                self?.updateAddButton()

            case .failure:
                break
            }
        }
    }

    @objc
    private func refresh() {
        refreshControl.endRefreshing()
        getWeather()
    }

    // Handle show activity indicator case
    private func handleEventsFromViewModel() {
        viewModel.showActivityIndicator = { [weak self] isShow in
            DispatchQueue.main.async {
                if isShow {
                    self?.showHUD()
                } else {
                    self?.hideHUD()
                }
            }
        }
    }
}

// MARK: - Setup Views
extension WeatherDetailViewController {
    private func updateAddButton() {
        addToListButton.layer.cornerRadius = 7
        addToListButton.titleLabel?.font = .systemFont(ofSize: 12)
        addToListButton.semanticContentAttribute = .forceRightToLeft
        addToListButton.imageEdgeInsets = .init(top: 0, left: 7, bottom: 0, right: -7)
        addToListButton.setBackgroundImage(
            viewModel.isAdded ?
            Assets.WeatherDetail.buttonAdded.image
            : Assets.WeatherDetail.buttonAdd.image,
            for: .normal
        )
    }

    private func addPullToRefresh() {
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        scrollView.refreshControl = refreshControl
    }

    private func updateUI(data: WeatherDetailViewData) {
        let overallWeather = data.overallWeather
        weatherImageView.image = overallWeather.weatherType?.weatherImage
        locationNameLabel.text = data.name
        temputareLabel.text = overallWeather.temperture
        weatherInfoView.loadData(data: data.weatherInformation)
        rainForecastView.setData(data: data.rainForecastViewData)
        rainForecastView.isHidden = !data.isRain
        updateAddButton()
    }
}

// MARK: - API Helper
extension WeatherDetailViewController {
    private func getWeather() {
        viewModel.getWeather { [weak self] result in
            switch result {
            case .success(let viewData):
                self?.updateUI(data: viewData)

            case .failure:
                break
            }
        }
    }
}
