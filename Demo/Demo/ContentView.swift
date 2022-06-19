//
//  ContentView.swift
//  Demo
//
//  Created by Robin Enhorn on 2022-06-18.
//

import SwiftUI
import OneLogger

struct ContentView: View {

    enum DemoError: Error {
        case someError
    }

    private let loggers: [OneLogger] = [
        OnePrintLogger(errorFormatters: [
            ErrorFormatter()
        ]),
        OneFileLogger(fileURL: .fileURL)
    ]

    @State var level: OneLogLevel = .debug

    var body: some View {
        VStack(spacing: 16) {
            Picker("Log level", selection: $level) {
                Text("Info").tag(OneLogLevel.info)
                Text("Debug").tag(OneLogLevel.debug)
                Text("Warning").tag(OneLogLevel.warning)
                Text("Error").tag(OneLogLevel.error)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
            .onChange(of: level) { level in
                setLevel(to: level)
            }

            Button("Print statements") {
                logMessages()
            }
        }.padding(16)
    }
}

private extension ContentView {

    func setLevel(to level: OneLogLevel) {
        for var logger in loggers {
            logger.level = level
        }
    }

    func logMessages() {
        for logger in loggers {
            logger.info("Info log message")
            logger.debug("Debug log message")
            logger.warning("Warning log message")
            logger.error(DemoError.someError)
        }
    }

}

struct ErrorFormatter: OneLoggerErrorFormatter {

    func format(_ error: Error) -> String? {
        "Formatted error message for: \(error)"
    }

}

private extension URL {

    // Located at:
    // ~/Library/Containers/com.enhorn.OneLoggerDemo/Data/Documents/OneLoggerDemo.log
    static var fileURL: URL {
        documentsDirectory.appendingPathComponent("OneLoggerDemo.log")
    }

    static var documentsDirectory: URL {
        FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
