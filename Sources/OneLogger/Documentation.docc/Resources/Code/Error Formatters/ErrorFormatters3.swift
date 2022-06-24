import OneLogger

enum FileReadingError: Error {
    case couldNotReadFile
    case fileWasEmpty
}

enum FileParsingError: Error {
    case wrongFileFormat
    case missingProperties
}

let logger = OnePrintLogger(level: .error, errorFormatters: [
    FileReadingErros(),
    FileParsingError
])

logger.error(FileReadingError.fileWasEmpty)
logger.error(FileReadingError.couldNotReadFile)
logger.error(FileParsingError.wrongFileFormat)
logger.error(FileParsingError.missingProperties)

// Console output
/*
🚨 [Reading] File was empty
🚨 [Reading] Could not read the file
🚨 [Parsing] Unexpected file format
🚨 [Parsing] File did not contain required properties
*/

class FileReadingFormatter: OneLoggerErrorFormatter {

    func format(_ error: Error) -> String? {
        guard let readingError = error as? FileReadingError
        else { return nil }

        switch readingError {
            case .couldNotReadFile:
                return "[Reading] Could not read the file"
            case .fileWasEmpty:
                return "[Reading] File was empty"
        }
    }

}

class FileParsingFormatter: OneLoggerErrorFormatter {

    func format(_ error: Error) -> String? {
        guard let parsingError = error as? FileParsingError
        else { return nil }

        switch parsingError {
            case .wrongFileFormat:
                return "[Parsing] Unexpected file format"
            case .missingProperties:
                return "[Parsing] File did not contain required properties"
        }
    }

}

