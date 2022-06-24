import OneLogger

let logger = OnePrintLogger(level: .info)

logger.info("Info message")
logger.debug("Debug message")
logger.warning("Warning message")
logger.error(someError)

// Console output
/*
ℹ️ Info message
🐛 Debug message
⚠️ Warning message
🚨 someError
*/
