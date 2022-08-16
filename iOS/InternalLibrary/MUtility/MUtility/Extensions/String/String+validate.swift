//
//  String+validate.swift
//  MUtility
//
//  Created by Tri Nguyen T. [2] on 1/24/22.
//

import Foundation

public extension String {
    var isPhoneNumber: Bool {
        let phoneRegEx = "^0(([7,8,9]{1}[0]{1})|([9]{1}[9]{1}))[0-9]{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }

    var isPassword: Bool {
        let regEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,20}$"
        let passTest = NSPredicate(format: "SELF MATCHES %@", regEx)
        return passTest.evaluate(with: self)
    }

    var isPotalCode: Bool {
        // Conform to the validation defined by the backend
        return self.range(of: #"^[0-9０-９]{3}[\-‑⁃–—―−ｰ﹣－ー]?[0-9０-９]{4}$"#, options: .regularExpression) != nil
    }
}
