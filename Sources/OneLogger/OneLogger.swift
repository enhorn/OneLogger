import Foundation

public enum OneLogLevel: Int {
    case info, debug, warning, error
}

public protocol OneLogger {

    /// Active log level for  for the logger.
    var level: OneLogLevel { get set }

    /// Log a message for the `.info` level.
    func info(_ message: String)

    /// Log a message for the `.debug` level.
    func debug(_ message: String)

    /// Log a message for the `.warning` level.
    func warning(_ message: String)

    /// Log an error for the `.info` level.
    func error(_ error: Error)

}

public extension OneLogger {

    /// If the logger should log at `.info` level.
    var shouldLogInfo: Bool { level.rawValue == OneLogLevel.info.rawValue }

    /// If the logger should log at `.debug` level.
    var shouldLogDebug: Bool { level.rawValue <= OneLogLevel.debug.rawValue }

    /// If the logger should log at `.waning` level.
    var shouldLogWarning: Bool { level.rawValue <= OneLogLevel.warning.rawValue }

    /// If the logger should log at `.error` level.
    var shouldLogError: Bool { level.rawValue <= OneLogLevel.error.rawValue }
}

/// Formats the error into a string.
public protocol OneLoggerErrorFormatter {
    func format(_ error: Error) -> String?
}
