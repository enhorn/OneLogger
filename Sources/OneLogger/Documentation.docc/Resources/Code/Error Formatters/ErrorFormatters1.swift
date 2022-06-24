import OneLogger

enum FileReadingError: Error {
    case couldNotReadFile
    case fileWasEmpty
}

enum FileParsingError: Error {
    case wrongFileFormat
    case missingProperties
}
