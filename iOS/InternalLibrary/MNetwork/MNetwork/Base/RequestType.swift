//
//  RequestType.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Alamofire
import Foundation
import MUtility

/// Borrowed from Moya.Task
/// Represents an HTTP task.
public enum RequestType {

    /// A request with no additional data.
    case requestPlain

    /// A request with url parameters.
    case requestUrlParameters(parameters: Parameters?)

    /// A request body set with `Encodable` type
    case requestJSONEncodable(Encodable)

    case requestRawParameters(parameters: Parameters?)

    var parameters: Parameters? {
        switch self {
        case .requestPlain:
            return nil

        case let .requestRawParameters(parameters):
            return parameters

        case let .requestUrlParameters(parameters):
            return parameters

        case let .requestJSONEncodable(parameters):
            // A snake case data dictionary
            return parameters.asDictionary()
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .requestPlain, .requestUrlParameters:
            return URLEncoding.default

        case .requestJSONEncodable, .requestRawParameters:
            // convert a parameter dictionary into json as a request body
            return JSONEncoding.default
        }
    }
}
