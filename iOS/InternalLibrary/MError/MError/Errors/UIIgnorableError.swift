//
//  UIIgnorableError.swift
//  MError
//
//  Created by MBP0003 on 1/10/22.
//

import Foundation

/// Certain server interactions should not display errors to the UI when they fail. Primarily endpoints that are only fetching the latest data, they can fall back to the
/// existing data set.
public final class UIIgnorableError: MError {
    public let underlyingError: MError

    public init(_ underlyingError: MError) {
        self.underlyingError = underlyingError
    }
}
