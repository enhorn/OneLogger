import OneLogger

class CustomLogger: OneLogger {

    // Local logger for info & debug logging.
    // Automatic selection between print logger and file logger
    // based on buld configuration.
    private var localLogger: OneLogger = {
        #if DEBUG
        return OnePrintLogger(level: .debug)
        #else
        return OneFileLogger(
            level: .debug,
            fileURL: URL(string: "path/to/your/file.log")
        )
        #endif
    }()

    var level: OneLogLevel = .debug {
        // Keep the local logger in sync.
        didSet { localLogger.level = level }
    }

    func info(_ message: String) {
        // Use local logger for info messages.
        localLogger.info(message)
    }

    func debug(_ message: String) {
        // Use local logger for debug messages.
        localLogger.debug(message)
    }


    func warning(_ message: String) {
        
    }

    func error(_ error: Error) {

    }


}
