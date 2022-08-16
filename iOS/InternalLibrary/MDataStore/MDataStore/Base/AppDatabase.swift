//
//  AppDatabase.swift
//  Windy
//
//  Created by Quang Phu C. M. on 7/31/22.
//

import Foundation
import MError
import UIKit
import MUtility
import CoreData

/// A type responsible for initializing the application database.
public struct AppDatabase {
    //    public static let context: DatabaseWriter =
    public init() { }

    public var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        // swiftlint:disable unneeded_parentheses_in_closure_argument
        let container = NSPersistentContainer(name: Constants.databaseFileName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    public static func setupDatabase(
        _ application: UIApplication,
        fileManager: FileManager,
        eraseOnSchemaChange: Bool = FeatureFlags.eraseDatabaseOnSchemaChange
    ) throws -> DatabaseWriter {
        throw MError(errorType: .databaseError, errorCode: 500)
    }
}

extension AppDatabase {
    enum Constants {
        static let databaseFileName = "WindyCoreData"
    }
}
