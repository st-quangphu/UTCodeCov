//
//  OrderFoodDataStore.swift
//  MModels
//
//  Created by Quang Phu C. M. on 7/1/22.
//

import Foundation
import MUtility

// Define the prototype support cache data in local (user default, keychains,...)
public protocol OrderFoodDataStoreType {
    var accessToken: String? { get set }
}

public class OrderFoodDataStore: OrderFoodDataStoreType {
    private enum ItemKeys {
        static let userToken = "user-auth-token"
    }

    private let keychain: KeychainType
    private let userDefault: UserDefaults

    public init(keychain: KeychainType, userDefault: UserDefaults) {
        self.keychain = keychain
        self.userDefault = userDefault
    }

    public var accessToken: String? {
        get {
            do {
                return try keychain.get(OrderFoodDataStore.ItemKeys.userToken)
            } catch {
                Log.debug(error.localizedDescription)
                assertionFailure(error.localizedDescription)
                return nil
            }
        }
        set {
            do {
                try keychain.set(newValue ?? "", key: OrderFoodDataStore.ItemKeys.userToken)
            } catch {
                Log.debug(error.localizedDescription)
                assertionFailure(error.localizedDescription)
            }
        }
    }
}
