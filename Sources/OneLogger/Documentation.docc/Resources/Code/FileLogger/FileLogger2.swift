import OneLogger

let logger = OneFileLogger(fileURL: URL(string: "path/to/your/file.log"))

logger.info("Info message")
logger.debug("Debug message")
logger.warning("Warning message")
logger.error(someError)

// Output in the file
/*
 2022-06-24 08:46:15.996 ℹ️ Info message
 2022-06-24 08:46:15.998 🐛 Debug message
 2022-06-24 08:46:15.998 ⚠️ Warning message
 2022-06-24 08:46:15.998 🚨 someError
*/
