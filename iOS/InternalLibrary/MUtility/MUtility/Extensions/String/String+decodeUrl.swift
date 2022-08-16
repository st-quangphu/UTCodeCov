//
//  String+decodeUrl.swift
//  MUtility
//
//  Created by Tri Nguyen T. [2] on 14/03/2022.
//

import Foundation

public extension String {

    func encodeUrl() -> String? {
        let pathChars = NSCharacterSet.urlPathAllowed.union(CharacterSet(charactersIn: "#"))
        let allowedCharacters = CharacterSet()
            .union(NSCharacterSet.urlHostAllowed)
            .union(NSCharacterSet.urlQueryAllowed)
            .union(NSCharacterSet.urlFragmentAllowed)
            .union(pathChars)
        return addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }

    func decodeUrl() -> String? {
        removingPercentEncoding
    }

    func encodeUrlOnce() -> String? {
        decodeUrl()?.decodeUrl()?.encodeUrl()
    }
}
