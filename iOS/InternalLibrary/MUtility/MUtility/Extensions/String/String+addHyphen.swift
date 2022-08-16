//
//  String+addHyphen.swift
//  MUtility
//
//  Created by MBP0003 on 2/8/22.
//

import Foundation

extension String {
    // Convert "09900001111" => "099-0000-1111"
    public func addHyphen() -> String {
        var tmp = self
        if tmp.count == 10 || tmp.count == 11 {
            tmp.insert(contentsOf: "-", at: tmp.index(tmp.startIndex, offsetBy: 3) )
            tmp.insert(contentsOf: "-", at: tmp.index(tmp.startIndex, offsetBy: 8) )
        }
        return tmp
    }

    public func addHyphen(at index: Int) -> String {
        guard index < self.count - 1 else { return self }
        var tmp = self
        tmp.insert(contentsOf: "-", at: tmp.index(tmp.startIndex, offsetBy: index))

        return tmp
    }
}
