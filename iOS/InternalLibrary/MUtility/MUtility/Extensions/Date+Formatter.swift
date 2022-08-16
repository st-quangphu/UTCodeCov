//
//  Date+Formatter.swift
//  MAUtility
//
//  Created by MBP0003 on 8/4/21.
//

import Foundation

public extension Date {
    /**
     Below are the examples of what each format gives for `2019-04-05`
     * `ja_JP`:
     ```
     d MMM yyyy: 2019年4月5日
     MMM YYYY: 2019年4月
     MMM d: 4月5日
     MMM: 4月
     d: 5日
     ```
     * `en_AU`:
     ```
     d MMM yyyy: 5 Apr 2019
     MMM YYYY: Apr 2019
     MMM d: 5 Apr
     MMM: Apr
     d: 5
     ```
     */
    enum DisplayFormat: String, CaseIterable {
        case mediumDate = "d MMM yyyy"
        case shortMonthYear = "MMM yyyy"
        case shortMonthDay = "MMM d"
        case shortMonthOnly = "MMM"
        case dayOnly = "d"
        case datetime = "yyyy/MM/dd HH:mm:ss"
        case datetimeWithoutSecond = "yyyy/MM/dd HH:mm"
        case date = "yyyy/MM/dd"
        case dateWithoutDay = "yyyy/MM"
        case dateWithoutSeparator = "yyyyMMdd"
        case datetimeWithoutSeparator = "yyyyMMddHHmmss"
        case datetimeWithSub = "yyyy-MM-dd HH:mm:ss"
        case hourMinutes = "HH:mm a"
    }

    enum DataFormat: CaseIterable {
        case monthYear
        case shortDate
        case internetDateAndTime // doesn't handle fractional seconds
        case fullInternetDateAndTime // handles fractional seconds

        fileprivate var iso8601FormatOptions: ISO8601DateFormatter.Options {
            switch self {
            case .monthYear:
                return [.withMonth, .withYear, .withDashSeparatorInDate]

            case .shortDate:
                return [.withFullDate, .withDashSeparatorInDate]

            case .internetDateAndTime:
                return [.withInternetDateTime]

            case .fullInternetDateAndTime:
                return [.withInternetDateTime, .withFractionalSeconds]
            }
        }
    }

    private static var formatter = DateFormatter()
    private static var iso8601Formatter = ISO8601DateFormatter()

    /// Convert a date into a most suitable localized date formatted string for UI display purposes in JST timezone.
    /// e.g. `shortDate` (yyyyMMdd) might return date string `MM/dd/yyyy`
    ///
    /// - Parameters:
    ///   - format: display format enum.
    ///   - locale: the locale of the formatted string, defaults to `ja_JP`.
    ///   - timeZone: the time zone of the formatted string, defaults to `JST`.
    /// - Returns: formatted string for display
    func displayString(_ format: DisplayFormat, in locale: Locale = .preferred, timeZone: TimeZone = .jst) -> String {
        let formatter = Date.formatter
        formatter.locale = locale
        formatter.timeZone = timeZone
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        formatter.setLocalizedDateFormatFromTemplate(format.rawValue)
        return formatter.string(from: self)
    }

    /// Convert a date into a most suitable date formatted string for data transactions in JST timezone.
    /// e.g. `internetDateAndTime` format could return `2015-02-01T13:16:50+09:00`
    ///
    /// - Parameters:
    ///   - format: data format enum
    /// - Returns: formatted string for data
    func dataString(_ format: DataFormat, timeZone: TimeZone = .jst) -> String {
        let formatter = Date.iso8601Formatter
        formatter.timeZone = timeZone
        formatter.formatOptions = format.iso8601FormatOptions
        return formatter.string(from: self)
    }
}

public extension DateFormatter {
    convenience init(displayFormat: Date.DisplayFormat, in locale: Locale = .preferred, timeZone: TimeZone = .jst) {
        self.init()
        self.locale = locale
        self.timeZone = timeZone
        setLocalizedDateFormatFromTemplate(displayFormat.rawValue)
    }
}

public extension ISO8601DateFormatter {
    convenience init(dataFormat: Date.DataFormat, timeZone: TimeZone = .jst) {
        self.init()
        self.timeZone = timeZone
        formatOptions = dataFormat.iso8601FormatOptions
    }
}
