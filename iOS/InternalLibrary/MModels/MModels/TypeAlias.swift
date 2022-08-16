//
//  TypeAlias.swift
//  MModels
//
//  Created by MBP0003 on 1/9/22.
//

import Foundation
import MError

public typealias EntityId = String

public typealias Balance = String

public typealias DecodableCompletion<T: Decodable> = (Result<T, MError>) -> Void

public typealias Completion<T> = (Result<T, MError>) -> Void

/// Result enum with an associated value for its failure case of type `MError`
public typealias MResult<T> = Result<T, MError>
