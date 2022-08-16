//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Rin Sang on 14/07/2022.
//

import UIKit
import MapKit
import MUtility
import Foundation
import MModels
import SnapKit

final class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var searchBarView: UIView!
    @IBOutlet private weak var listButton: UIButton!

    // MARK: - Privates
    private var navigator: HomeNavigator.Type
    private var viewModel: HomeViewModelType
    private var refreshControl = UIRefreshControl()
    private var slides: [WeatherDetailView] = []
    private var listHomeView: ListHomeView?

    init(
        navigator: HomeNavigator.Type,
        viewModel: HomeViewModelType
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
        handleEventsFromViewModel()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }

    private func addPullToRefresh() {
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        scrollView.refreshControl = refreshControl
    }

    @objc
    private func refresh() {
        refreshControl.endRefreshing()
        for subView in scrollView.subviews {
            subView.removeFromSuperview()
        }
        slides = []
        getBookmarkedWeathers()
    }

    /// Handle show activity indicator case
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

    @IBAction private func searchTouch(_ sender: Any) {
        _ = navigator.navigate(to: .search, from: self)
    }

    @IBAction private func listButtonTouchUpInside(_ sender: Any) {
        if let listHomeView = listHomeView {
            listButton.isSelected = false
            listHomeView.removeFromSuperview()
            self.listHomeView = nil
            setupUISlide()
            refresh()
        } else {
            let listHomeView = ListHomeView()
            listHomeView.viewModel = viewModel.viewModelForListHomeView()
            listButton.isSelected = true
            containerView.addSubview(listHomeView)
            listHomeView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            self.listHomeView = listHomeView
        }
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        if pageNumber == pageControl.currentPage { return }
        pageControl.currentPage = pageNumber
        getLocationWeather(index: pageNumber)
    }
}

extension HomeViewController: SubviewsSetupable {
    func setupSubviews() {
        self.navigationController?.isNavigationBarHidden = true
        scrollView.delegate = self
        searchBarView.layer.cornerRadius = 15
//        addPullToRefresh()
        setupListButtonView()
    }

    private func setupListButtonView() {
        listButton.layer.cornerRadius = 25
        listButton.layer.shadowColor = UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 0.1).cgColor
        listButton.layer.shadowOpacity = 1
        listButton.layer.shadowRadius = 5
        listButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        listButton.layer.bounds = listButton.bounds
        listButton.layer.position = listButton.center
    }

    private func setupUISlide() {
        pageControl.numberOfPages = viewModel.locationNumber
        pageControl.currentPage = 0
        scrollView.isPagingEnabled = true
        let width = UIScreen.main.bounds.width
        for i in 0 ..< viewModel.locationNumber {
            let weatherDetailView = WeatherDetailView()
            weatherDetailView.frame = CGRect(x: width * CGFloat(i),
                                             y: 0,
                                             width: width,
                                             height: scrollView.frame.height)
            scrollView.addSubview(weatherDetailView)
            slides.append(weatherDetailView)
        }
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(slides.count),
                                        height: self.scrollView.frame.size.height)
    }
}

// MARK: - Api Helper
extension HomeViewController {
    private func getBookmarkedWeathers() {
        viewModel.getBookmarkedWeathers { [weak self] result in
            switch result {
            case .success(let list):
                if list.isEmpty {
                    self?.getCurrentLocation()
                } else {
                    self?.setupUISlide()
                    self?.getLocationWeather(index: 0)
                }

            case .failure:
                self?.getCurrentLocation()
            }
        }
    }

    private func getCurrentLocation() {
        viewModel.requestLocationPermission { [weak self] status in
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                self?.viewModel.getCurrentLocation { result in
                    switch result {
                    case .success:
                        self?.getLocationWeather(index: 0)
                        self?.setupUISlide()

                    case .failure:
                        break
                    }
                }
            }
        }
    }

    private func getLocationWeather(index: Int) {
        viewModel.getLocationWeather(index: index) { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let weatherDetailViewData):
                DispatchQueue.main.async {
                    this.slides[safe: index]?.loadData(data: weatherDetailViewData)
                }

            case .failure: break
            }
        }
    }
}
