//
//  UserDefaultAccessor .swift
//  MService
//
//  Created by Rin Sang on 02/08/2022.
//

import UIKit
import Foundation
import Darwin

class UserDefaultAccessor {

    // Define Signleton
    static let shared = UserDefaultAccessor()

    // Private properties
    private var standard = UserDefaults.standard

    public init(userDefauts: UserDefaults = .standard) {
        standard = userDefauts
    }

    // Helper for base data type
    func setValue(_ value: Any?, forKey: String) {
        standard.set(value, forKey: forKey)
    }

    func getValue(forKey: String) -> Any? {
        standard.value(forKey: forKey)
    }

    // Helper for custom object
    func saveObject<T: Codable>(_ value: T?, forKey: String) {
        let encoder = JSONEncoder()
        if let data: Data = try? encoder.encode(value) {
            standard.set(data, forKey: forKey)
        }
    }

    func saveObjects<T: Codable>(_ value: [T]?, forKey: String) {
        let encoder = JSONEncoder()
        if let data: Data = try? encoder.encode(value) {
            standard.set(data, forKey: forKey)
        }
    }

    func getObject<T: Codable>(type: T.Type, key: String) -> T? {
        let decoder = JSONDecoder()
        if let data = standard.value(forKey: key) as? Data {
            let result = try? decoder.decode(T.self, from: data)
            return result
        }
        return nil
    }

    func getObjects<T: Codable>(type: T.Type, key: String) -> [T] {
        let decoder = JSONDecoder()
        if let data = standard.value(forKey: key) as? Data {
            let result = try? decoder.decode([T].self, from: data)
            return result ?? []
        }
        return []
    }
}
