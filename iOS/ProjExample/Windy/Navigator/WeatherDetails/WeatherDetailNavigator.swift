//
//  WeatherDetailNavigator.swift
//  Windy
//
//  Created by Rin Sang on 21/07/2022.
//

import MNavigator
import UIKit

struct WeatherDetailNavigator: MNavigator.WeatherDetailNavigator {
    static func navigate(
        to destination: WeatherDetailDestination,
        from context: UIViewController
    ) -> UIViewController? {
        switch destination {
        case .search:
            context.navigationController?.popViewController(animated: true)
        }
        return UIViewController()
    }
}
