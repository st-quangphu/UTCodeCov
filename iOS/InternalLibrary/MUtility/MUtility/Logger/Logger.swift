//
//  Logger.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

public enum LogLevel: Int, Comparable {
    case error = 0
    case warning
    case event
    case info
    case debug

    var tagName: String {
        switch self {
        case .error: return "[ERROR]"
        case .warning: return "[WARNING]"
        case .event: return "[EVENT]"
        case .info: return "[INFO]"
        case .debug: return "[DEBUG]"
        }
    }

    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

public protocol Logger {
    static func debug(_ message: String, file: String, line: Int)
    static func info(_ message: String, file: String, line: Int)
    static func event(_ message: String, file: String, line: Int)
    static func warning(_ message: String, file: String, line: Int)
    static func error(_ message: String, file: String, line: Int)

    /**
     Set the minimum level to log.
     The log level priorities are in below order:
     ```error > warning > event > info > debug```
     */
    static func setLogLevel(_ newLevel: LogLevel)

    /**
     Optional closure that is executed after message is logged.
     */
    static func setDidLogMessage(_ block: @escaping (LogLevel, String) -> Void)
}
