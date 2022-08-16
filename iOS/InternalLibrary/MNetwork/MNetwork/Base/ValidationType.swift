//
//  ValidationType.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

// Represents the status codes to validate through Alamofire.
public enum ValidationType {

    /// No validation.
    case none

    /// Validate success codes (only 2xx).
    case successCodes

    /// Validate success codes and redirection codes (only 2xx and 3xx).
    case successAndRedirectCodes

    /// Validate only the given status codes.
    case customCodes([HttpStatus.Code])
}
