//
//  CoreDataAccessor.swift
//  MService
//
//  Created by Quang Phu C. M. on 7/28/22.
//

import Foundation
import MError
import MModels
import CoreData

public class CoreDataAccessor {
  let database: DatabaseWriter

  public init(databaseWriter: DatabaseWriter) {
    database = databaseWriter
  }

  public func write<T: CDRecordable>(dtoArray: [T], type: T.Type) throws {
    dtoArray.forEach { item in
      item.save(db: database)
    }
    try database.save()
  }

  public func writeOne<T: CDRecordable>(dto: T, type: T.Type) throws {
    dto.save(db: database)
    try database.save()
  }

  public func delete<T: CDRecordable>(dtoArray: [T], type: T.Type) throws {
    try dtoArray.forEach { item in
      try deleteOne(dto: item, type: T.self)
    }
  }

  public func deleteOne<T: CDRecordable>(dto: T, type: T.Type) throws {
    let fetchRequest: NSFetchRequest<CDRecord> = NSFetchRequest(entityName: T.entityName)
    fetchRequest.predicate = dto.uniquePredicate
    if let obj = try database.fetch(fetchRequest).first {
      database.delete(obj)
    }
  }

  public func fetchAll<T: CDRecordable>(type: T.Type) throws -> [T] {
    let fetchRequest: NSFetchRequest<CDRecord> = NSFetchRequest(entityName: T.entityName)
    let items: [CDRecord] = try database.fetch(fetchRequest)
    return items.map({ T(record: $0) })
  }

  public func filter<T: CDRecordable>(_ predicate: NSPredicate?, type: T.Type) throws -> [T] {
    let fetchRequest: NSFetchRequest<CDRecord> = NSFetchRequest(entityName: T.entityName)
    fetchRequest.predicate = predicate
    let items = try database.fetch(fetchRequest)
    return items.map({ T(record: $0) })
  }
}
