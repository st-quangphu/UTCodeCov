//
//  Log.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation
import os

@available(iOS 12, *)
extension LogLevel {
    var osLogType: OSLogType {
        switch self {
        case .debug: return .debug
        case .info: return .info
        case .event: return .info
        case .warning: return .default
        case .error: return .error
        }
    }
}

public struct Log {
    private static var shared: Log = {
        if Macros.isDebug {
            return Log(level: .debug, didLogMessage: nil)
        } else {
            return Log(level: .error, didLogMessage: nil)
        }
    }()

    private(set) var level: LogLevel
    private(set) var didLogMessage: ((LogLevel, String) -> Void)?

    private init(level: LogLevel, didLogMessage: ((LogLevel, String) -> Void)?) {
        self.level = level
        self.didLogMessage = didLogMessage
    }

    private func write(level: LogLevel, file: String = #file, line: Int = #line, message: String) {
        // Bail out if logging for level below the set level.
        guard level <= self.level else { return }

        let filename = file.components(separatedBy: "/").last ?? file

        if #available(iOS 12, *) {
            os_log(level.osLogType, "%@[%@:%@] %@", level.tagName, filename, line.description, message)
        } else {
            os_log("%@[%@:%@] %@", level.tagName, filename, line.description, message)
        }

        didLogMessage?(level, message)
    }
}

extension Log: Logger {
    public static func debug(_ message: String, file: String = #file, line: Int = #line) {
        Log.shared.write(level: .debug, file: file, line: line, message: message)
    }

    public static func info(_ message: String, file: String = #file, line: Int = #line) {
        Log.shared.write(level: .info, file: file, line: line, message: message)
    }

    public static func event(_ message: String, file: String = #file, line: Int = #line) {
        Log.shared.write(level: .event, file: file, line: line, message: message)
    }

    public static func warning(_ message: String, file: String = #file, line: Int = #line) {
        Log.shared.write(level: .warning, file: file, line: line, message: message)
    }

    /// Caution: Currently error log will be forward to Firebase, be cautious for what we are logging to avoid logging PII accidentally
    /// See  FirebaseConfigurator for more info
    public static func error(_ message: String, file: String = #file, line: Int = #line) {
        Log.shared.write(level: .error, file: file, line: line, message: message)
    }

    public static func setLogLevel(_ newLevel: LogLevel) {
        Log.shared.level = newLevel
    }

    public static func setDidLogMessage(_ block: @escaping (LogLevel, String) -> Void) {
        shared.didLogMessage = block
    }
}
