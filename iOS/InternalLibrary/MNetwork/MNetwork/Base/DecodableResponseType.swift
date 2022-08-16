//
//  DecodableResponseType.swift
//  MANetwork
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

public enum DecodableResponseType {
    // TODO: - The following two cases cope with existing API request scenarios only
    // If we ever need more features such as decode multiple header fields at the same time
    // Or decode body and header at the same time, this implementation needs to be extended
    case body
    case header(keyType: HttpHeaderKeyType.Type)
    case data
    case none
}
