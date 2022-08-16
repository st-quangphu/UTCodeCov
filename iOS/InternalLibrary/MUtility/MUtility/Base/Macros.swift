//
//  Macros.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

// This class should not be used directly in the project.
// More fine grained control via FeatureFlags instead
public final class Macros {
    public static var isDebug = false

    public static var isRunningUnitTests = true

    public static var isRunningUITests = false

    public static var isDemoMode = false

    public static var environment: NetworkEnvironment?
}
