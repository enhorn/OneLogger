//
//  File.swift
//  
//
//  Created by Robin Enhorn on 2022-06-18.
//

import Foundation

public class OnePrintLogger: OneLogger {

    /// Acitve log level.
    public var level: OneLogLevel

    /// A list of error fomratters. Will use the first formatter that produces a string for the given error.
    public var errorFormatters: [OneLoggerErrorFormatter] = []

    /// - Parameters:
    ///   - level: Initial acitve log level. Defualts to `.debug`.
    ///   - errorFormatters: A list of error fomratters. Will use the first formatter that produces a string for the given error. Defaults to `[]`.
    public init(level: OneLogLevel = .debug, errorFormatters: [OneLoggerErrorFormatter] = []) {
        self.level = level
        self.errorFormatters = errorFormatters
    }

    public func info(_ message: String) {
        guard shouldLogInfo else { return }
        print("ℹ️ \(message)")
    }

    public func debug(_ message: String) {
        guard shouldLogDebug else { return }
        print("🐛 \(message)")
    }

    public func warning(_ message: String) {
        guard shouldLogWarning else { return }
        print("⚠️ \(message)")
    }

    public func error(_ error: Error) {
        guard shouldLogError else { return }
        print("🚨 \(error.message(using: errorFormatters))")
    }

}
