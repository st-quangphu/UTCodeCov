//
//  SearchNavigator.swift
//  Windy
//
//  Created by Rin Sang on 21/07/2022.
//
import MNavigator
import UIKit

struct SearchNavigator: MNavigator.SearchNavigator {
    static func navigate(
        to destination: SearchDestination,
        from context: UIViewController
    ) -> UIViewController? {
        switch destination {
        case .weatherDetail(let place):
            let vm = WeatherDetailViewModel(
                place: place,
                windyService: UIApplication.serviceProvider.weatherService
            )
            let vc = WeatherDetailViewController(
                viewModel: vm,
                navigator: WeatherDetailNavigator.self
            )
            context.show(vc, sender: self)
            return vc

        case .home:
            context.navigationController?.popViewController(animated: true)
        }
        return UIViewController()
    }
}
