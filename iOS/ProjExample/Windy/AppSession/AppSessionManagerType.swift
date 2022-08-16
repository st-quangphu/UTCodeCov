//
//  AppSessionManagerType.swift
//  Majica
//
//  Created by MBP0003 on 1/11/22.
//

import MService
import UIKit

// MARK: - LogoutCleaner

public protocol LogoutCleaner {
    /// Clears out all stored user data and the app session.
    /// Use this to completely reset the application state.
    func cleanUp()

    /// Clears out temporary data that is stored in the session throughout the authorization process, including tokens
    /// and user profile data.
    /// Use this when you have not completed logging in and need to restart the process.
    func resetSession()
}

// MARK: - AppSessionMangerType

public protocol AppSessionManagerType: LogoutCleaner {

    var serviceProvider: ServiceProviderType { get }

    var isUserLoggedIn: Bool { get }

    /// Replace the window's root view controller with tab bar controller and show home page
    @discardableResult
    func navigateToHomePage() -> UIViewController?

    /// Replace the window's root view controller with landing page or login page
    @discardableResult
    func navigateToLandingPage() -> UIViewController?
}
