//
//  CDRecordable.swift
//  MService
//
//  Created by Quang Phu C. M. on 7/31/22.
//

import Foundation
import CoreData

public protocol CDRecordable {
    /// The table name be defined in CoreData Entities
    static var entityName: String { get }

    /// The predicate to specify it's unique
    var uniquePredicate: NSPredicate? { get }

    /// Return DTO object from NSManagedObject
    /// - Parameter record: The NSManagedObject's instance
    init(record: CDRecord)

    /// Save the dto object to database
    /// - Parameter db: The database context
    func save(db: DatabaseWriter)
}
