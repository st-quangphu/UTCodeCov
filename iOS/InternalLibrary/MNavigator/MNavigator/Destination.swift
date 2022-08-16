//
//  Destination.swift
//  MNavigator
//
//  Created by MBP0003 on 1/9/22.
//

import Foundation
import MModels
import MapKit

/// A semantic type for sets of possible screens to navigate to.
/// A destination can have associated values in order to pass values into the view model of the screen to be presented.
public protocol Destination {}

// MARK: - App Session

public enum AppSessionDestination: Destination {
    case home
    case landingPage
}

// MARK: - Onboarding

public enum LandingPageDestination: Destination {
    case signUp
    case login
}

public enum WeatherDestination: Destination {
    case detail
    case searchLocation
}

// MARK: - Home
public enum HomeDestination: Destination {
    case search
}

// MARK: - Search
public enum SearchDestination: Destination {
    case weatherDetail(place: MKMapItem)
    case home
}

// MARK: - WeatherDetail
public enum WeatherDetailDestination: Destination {
    case search
}
