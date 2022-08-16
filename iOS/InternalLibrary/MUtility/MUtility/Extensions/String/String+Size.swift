//
//  String+Size.swift
//  MUtility
//
//  Created by Tri Nguyen T. [2] on 2/11/22.
//

import Foundation

public extension String {
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes: [NSAttributedString.Key: Any]? = [.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size
    }
}
