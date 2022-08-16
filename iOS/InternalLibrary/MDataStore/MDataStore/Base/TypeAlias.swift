//
//  TypeAlias.swift
//  MService
//
//  Created by Quang Phu C. M. on 7/28/22.
//

import Foundation
import CoreData
import MError

public typealias DatabaseWriter = NSManagedObjectContext
public typealias CDRecord = NSManagedObject
public typealias Count = Int

public enum DataStoreAccessResult {
    public typealias Void = Result<Swift.Void, MError>
    public typealias Single<T> = Result<T?, MError>
    public typealias Count = Result<MDataStore.Count, MError>
    public typealias Many<T> = Result<[T], MError>
}
