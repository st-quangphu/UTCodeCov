//
//  AppSessionManager.swift
//  Majica
//
//  Created by MBP0003 on 1/11/22.
//

import Foundation
import MNavigator
import MNetwork
import MService
import MUtility
import UIKit

public final class AppSessionManager: NSObject {

    private let application: UIApplication
    private let environment: NetworkEnvironment
    private let notificationCenter: NotificationCenter
    private let navigator: AppSessionNavigator.Type
    private var appDatabase = AppDatabase()

    // swiftlint:disable:next implicitly_unwrapped_optional
    private var serviceProvider_: ServiceProviderType!

    init(
        environment: NetworkEnvironment,
        navigator: AppSessionNavigator.Type,
        application: UIApplication = UIApplication.shared,
        notificationCenter: NotificationCenter = .default
    ) {
        // keep all the parameters for later use
        self.application = application
        self.environment = environment
        self.notificationCenter = notificationCenter
        self.navigator = navigator

        super.init()
        setupNewSession()

        Log.debug("Session Manager initialized")
        subscribeToNotifications()
    }

    /// Renew all instances managed by this manager that hold the application session's state.
    /// It will reset/recreate:
    ///   - Service Provider
    ///   - Refresh Manager (Data Sync)
    ///
    /// Parameters:
    ///
    private func setupNewSession(erasingDatabase: Bool = false) {
        let networkSessionManager = SessionManager.makeWithMajicaConfiguration(environment: environment)
        serviceProvider_ = ServiceProvider(
            environment: environment,
            sessionManager: networkSessionManager,
            notificationCenter: notificationCenter,
            database: appDatabase.persistentContainer.viewContext
        )
    }
}

extension AppSessionManager: AppSessionManagerType {

    public var serviceProvider: ServiceProviderType {
        serviceProvider_
    }

    public var isUserLoggedIn: Bool {
        false // Should be get state from authService
    }

    public func navigateToHomePage() -> UIViewController? {
        guard let topViewController = UIApplication.topViewController() else {
            Log.debug("Trying to present home page while no view controller is visible, ignoring the request")
            return nil
        }

        return navigator.navigate(to: .home, from: topViewController)
    }

    public func navigateToLandingPage() -> UIViewController? {
        guard let topViewController = UIApplication.topViewController() else {
            Log.debug("Trying to present home page while no view controller is visible, ignoring the request")
            return nil
        }

        return navigator.navigate(to: .landingPage, from: topViewController)
    }

    public func cleanUp() {
        Log.debug("AppSessionManger.cleanup()")
    }

    public func resetSession() {
    }

    private func forceLogout(message: String?) {
        // cleanup before showing the alert
        cleanUp()
    }
}

// MARK: - Private Functions For Notification Observer

private extension AppSessionManager {
    func subscribeToNotifications() {
        notificationCenter.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: nil
        ) { _ in }

        notificationCenter.addObserver(
            forName: .forceLogout,
            object: nil,
            queue: nil
        ) { [weak self] notification in
            DispatchQueue.main.async {[weak self] in
                let message = notification.object as? String
                self?.forceLogout(message: message)
            }
        }
    }
}
