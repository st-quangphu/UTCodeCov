//
//  TypeAlias.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Alamofire
import Foundation

// MARK: - Alamofires Typealiases

// Upper modules should not refer to Alamofire directly in any cases
public typealias Request = Alamofire.Request
public typealias DataRequest = Alamofire.DataRequest
public typealias DataResponse = Alamofire.DataResponse
public typealias HttpHeaders = Alamofire.HTTPHeaders
public typealias HttpMethod = Alamofire.HTTPMethod
public typealias Parameters = Alamofire.Parameters
public typealias ParameterEncoding = Alamofire.ParameterEncoding
public typealias SessionManager = Alamofire.SessionManager
public typealias ValidationResult = Alamofire.Request.ValidationResult
