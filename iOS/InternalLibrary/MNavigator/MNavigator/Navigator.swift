//
//  Navigator.swift
//  MNavigator
//
//  Created by MBP0003 on 1/9/22.
//

import Foundation

/// The Navigator protocol is a semantic type.
/// Each screen, or simple feature flow, should have an associated Navigator protocol and concrete type. Each Navigator
/// has an associate Destination enum.
///
/// The Navigator and Destination together limit the paths that a user can take through the app.
///
/// The concrete implementation of a navigator protocol is responsible for building and presenting view controllers.
/// This architecture reduces the scope of each individual view controller and improves separation of concerns.
///
/// Note that there is some boilerplate involved in creating specific Navigator protocols with its own Destination enum
/// for each screen. Ideally we would use an associated type for the Destination, but associated types cannot be used
/// for property types.
public protocol Navigator {}

public protocol AppSessionNavigator: Navigator {
    @discardableResult
    static func navigate(
        to destination: AppSessionDestination,
        from context: UIViewController
    ) -> UIViewController?
}

// MARK: - Onboarding

public protocol LandingPageNavigator: Navigator {
    @discardableResult
    static func navigate(
        to destination: LandingPageDestination,
        from context: UIViewController
    ) -> UIViewController?
}

public protocol WeatherNavigator: Navigator {
    @discardableResult
    static func navigate(
        to destination: WeatherDestination,
        from context: UIViewController
    ) -> UIViewController?
}
// MARK: - HomeNavigator
public protocol HomeNavigator: Navigator {
    @discardableResult
    static func navigate(
        to destination: HomeDestination,
        from context: UIViewController
    ) -> UIViewController?
}

// MARK: - SearchNavigator
public protocol SearchNavigator: Navigator {
    static func navigate(
        to destination: SearchDestination,
        from context: UIViewController
    ) -> UIViewController?
}

// MARK: - WeatherDetailNavigator
public protocol WeatherDetailNavigator: Navigator {
    static func navigate(
        to destination: WeatherDetailDestination,
        from context: UIViewController
    ) -> UIViewController?
}
