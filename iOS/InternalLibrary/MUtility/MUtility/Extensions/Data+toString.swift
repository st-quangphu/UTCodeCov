//
//  Data+toString.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

public extension Data {
    func toString(encoding: String.Encoding = .utf8) -> String? {
        String(data: self, encoding: encoding)
    }
}
