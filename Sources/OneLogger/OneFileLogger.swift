//
//  File.swift
//  
//
//  Created by Robin Enhorn on 2022-06-19.
//

import Foundation

public class OneFileLogger: OneLogger {

    /// Acitve log level.
    public var level: OneLogLevel

    /// A list of error fomratters. Will use the first formatter that produces a string for the given error.
    public var errorFormatters: [OneLoggerErrorFormatter] = []

    /// URL to the file where the output should go.
    public let fileURL: URL

    /// - Parameters:
    ///   - level: Initial acitve log level. Defualts to `.debug`.
    ///   - errorFormatters: A list of error fomratters. Will use the first formatter that produces a string for the given error. Defaults to `[]`.
    ///   - fileURL: URL to the file where the output  should go.
    public init(level: OneLogLevel = .debug, errorFormatters: [OneLoggerErrorFormatter] = [], fileURL: URL) {
        self.level = level
        self.errorFormatters = errorFormatters
        self.fileURL = fileURL
    }

    public func info(_ message: String) {
        guard shouldLogInfo else { return }
        append("âšī¸ \(message)\n", to: fileURL)
    }

    public func debug(_ message: String) {
        guard shouldLogDebug else { return }
        append("đ \(message)\n", to: fileURL)
    }

    public func warning(_ message: String) {
        guard shouldLogWarning else { return }
        append("â ī¸ \(message)\n", to: fileURL)
    }

    public func error(_ error: Error) {
        guard shouldLogError else { return }
        append("đ¨ \(error.message(using: errorFormatters))\n", to: fileURL)
    }

}

private extension OneFileLogger {

    func append(_ message: String, to fileURL: URL) {
        let withTimeStamp = "\(timestamp) \(message)"
        
        if let handle = FileHandle(forWritingAtPath: fileURL.path), let data = withTimeStamp.data(using: .utf8) {
            defer { handle.closeFile() }
            handle.seekToEndOfFile()
            handle.write(data)
        } else {
            do {
                try withTimeStamp.write(to: fileURL, atomically: true, encoding: .utf8)
            } catch let error {
                #if DEBUG
                print("đ¨ \(error)")
                #endif
            }
        }
    }

    private var timestamp: String {
        DateFormatter.timeStamp.string(from: Date())
    }

}

extension DateFormatter {

    static let timeStamp: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter
    }()

}
