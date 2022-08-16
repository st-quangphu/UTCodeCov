//
//  UIApplication+Singleton.swift
//  Template
//
//  Created by Long Vo M. on 7/13/22.
//

import MService
import UIKit
import MModels

extension UIApplication {
    static var serviceProvider: ServiceProviderType {
        (UIApplication.shared.delegate as! AppDelegate).appSessionManager.serviceProvider
    }
}
