//
//  SessionManageable.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Alamofire
import Foundation

public protocol SessionManageable {
    var interceptor: HttpRequestInterceptorType? { get }

    /// The following properties and func are the same in class `SessionManager`
    /// The session delegate handling all the task and session delegate callbacks.
    var delegate: SessionDelegate { get }

    func attach(interceptor: HttpRequestInterceptorType?)

    func request(
        _ url: URLConvertible,
        method: HttpMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HttpHeaders?
    ) -> DataRequest

    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}
