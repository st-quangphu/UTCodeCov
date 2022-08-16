//
//  AppDelegate.swift
//  Majica
//
//  Created by MBP0003 on 1/9/22.
//

import MNavigator
import MUtility
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    #if PRODUCTION
    private static let environment: NetworkEnvironment = .production
    private static let launchScreenStoryboard = "LaunchScreen"
    #elseif STAGING
    private static let environment: NetworkEnvironment = .staging
    private static let launchScreenStoryboard = "LaunchScreenStaging"
    #else
    // Dev by default
    private static let environment: NetworkEnvironment = .dev
    private static let launchScreenStoryboard = "LaunchScreenDev"
    #endif

    /// Lauch the application without `SceneDelegate` https://stackoverflow.com/questions/60445104/info-plist-configuration-no-name-for-uiwindowscenesessionroleapplication
    var window: UIWindow?
    var appSessionManager: AppSessionManagerType

    override init() {
        AppDelegate.configMacros()
        appSessionManager = AppSessionManager(
            environment: AppDelegate.environment,
            navigator: AppSessionNavigator.self
        )
        super.init()
    }

    private static func configMacros() {
        #if DEBUG
        Macros.isDebug = true
        #else
        Macros.isDebug = false
        #endif

        Macros.environment = environment

        Macros.isDemoMode = environment == .dev
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: AppDelegate.launchScreenStoryboard, bundle: nil)
            .instantiateInitialViewController()
        window?.makeKeyAndVisible()

        if appSessionManager.isUserLoggedIn {
            appSessionManager.navigateToHomePage()
        } else {
            // Calling this cleanup method within didFinishLaunchingWithOptions synchronously may cause keychain deadlock.
            // Hance wrapping it in DispatchQueue.main.async
            // Clean up the app if the app launches without a full token in the storage
            self.appSessionManager.cleanUp()
            appSessionManager.navigateToLandingPage()
        }

        return true
    }
}
