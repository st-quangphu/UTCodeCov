//
//  HomeNavigator.swift
//  WindyDev
//
//  Created by Long Vo M. on 7/25/22.
//

import Foundation
import MNavigator
import MModels
import MService

struct HomeNavigator: MNavigator.HomeNavigator {
    @discardableResult
    static func navigate(to destination: HomeDestination, from context: UIViewController) -> UIViewController? {
        switch destination {
        case .search:
            let viewModel = SearchViewModel(
                locationService: UIApplication.serviceProvider.locationService,
                windyService: UIApplication.serviceProvider.weatherService
            )
            let viewController = SearchViewController(navigator: SearchNavigator.self,
                                                      viewModel: viewModel)
            context.show(viewController, sender: self)
            return viewController
        }
    }
}
