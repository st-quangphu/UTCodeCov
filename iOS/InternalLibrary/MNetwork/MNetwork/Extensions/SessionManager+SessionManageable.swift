//
//  SessionManager+SessionManageable.swift
//  MANetwork
//
//  Created by MBP0003 on 8/5/21.
//

import Foundation

// MARK: - SessionManageable

extension SessionManager: SessionManageable {
    public var interceptor: HttpRequestInterceptorType? {
        adapter as? HttpRequestInterceptorType ?? retrier as? HttpRequestInterceptorType
    }

    public func attach(interceptor: HttpRequestInterceptorType?) {
        adapter = interceptor
        retrier = interceptor
    }
}
