//
//  AppSessionNavigator.swift
//  Majica
//
//  Created by MBP0003 on 1/11/22.
//

import MNavigator
import UIKit

struct AppSessionNavigator: MNavigator.AppSessionNavigator {
    static func navigate(
        to destination: AppSessionDestination,
        from context: UIViewController
    ) -> UIViewController? {
        switch destination {

        case .landingPage:
            let viewModel = HomeViewModel(locationService: UIApplication.serviceProvider.locationService,
                                          windyService: UIApplication.serviceProvider.weatherService)
            let vc = HomeViewController(navigator: HomeNavigator.self, viewModel: viewModel)
            let navi = UINavigationController(rootViewController: vc)
            context.view.window?.rootViewController = navi
            return vc

        case .home:
            let vc = UIViewController()
            context.view.window?.rootViewController = vc
            return vc
        }
    }
}
