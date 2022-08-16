//
//  ForcedLogoutPublisher.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

// Anything conforming to this protocol will have the ability to post a notification informing any interested parties
// that the app should force log out. A message can be provided to present to the guest.
public protocol ForcedLogoutPublisher {
    var notificationCenter: NotificationCenter { get }
    func publishForcedLogoutNotification(message: String?)
}

extension ForcedLogoutPublisher {
    public func publishForcedLogoutNotification(message: String?) {
        notificationCenter.post(name: .forceLogout, object: message)
    }
}
