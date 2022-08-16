// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum ResourceStrings {

  public enum Alert {
    public enum Message {
      /// I can't complete the procedure at this time. Please wait a while and try again. We apologize for the inconvenience.
      public static let connectionError = ResourceStrings.tr("Localizable", "alert.message.connection_error")
    }
  }

  public enum Common {
    public enum Button {
      /// cancel
      public static let cancel = ResourceStrings.tr("Localizable", "common.button.cancel")
      /// done
      public static let done = ResourceStrings.tr("Localizable", "common.button.done")
      /// ok
      public static let ok = ResourceStrings.tr("Localizable", "common.button.ok")
      /// return back
      public static let returnBack = ResourceStrings.tr("Localizable", "common.button.return_back")
    }
    public enum Error {
      /// common.error.title.generic_message
      public static let genericMessage = ResourceStrings.tr("Localizable", "common.error.generic_message")
      /// Error
      public static let title = ResourceStrings.tr("Localizable", "common.error.title")
    }
  }

  public enum Error {
    public enum _503 {
      public enum Alert {
        /// Please restart the app after a while
        public static let message = ResourceStrings.tr("Localizable", "error.503.alert.message")
        /// Under maintenance
        public static let title = ResourceStrings.tr("Localizable", "error.503.alert.title")
      }
    }
    public enum _5xx {
      public enum Alert {
        /// Please try again
        public static let message = ResourceStrings.tr("Localizable", "error.5xx.alert.message")
        /// System error
        public static let title = ResourceStrings.tr("Localizable", "error.5xx.alert.title")
      }
    }
    public enum SslCertificate {
      public enum Alert {
        /// You cannot use it right now. Please wait a while and then start the application again.
        public static let message = ResourceStrings.tr("Localizable", "error.ssl_certificate.alert.message")
      }
    }
  }

  public enum SearchVenues {
    /// Search
    public static let tabTitle = ResourceStrings.tr("Localizable", "search_venues.tab_title")
    /// Search
    public static let title = ResourceStrings.tr("Localizable", "search_venues.title")
  }

  public enum TrendingVenues {
    /// Trending
    public static let tabTitle = ResourceStrings.tr("Localizable", "trending_venues.tab_title")
    /// Trending
    public static let title = ResourceStrings.tr("Localizable", "trending_venues.title")
  }

  public enum WeatherDetail {
    /// Add to list
    public static let addToList = ResourceStrings.tr("Localizable", "weather_detail.add_to_list")
    /// Added to list
    public static let addedToList = ResourceStrings.tr("Localizable", "weather_detail.added_to_list")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension ResourceStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
