import OneLogger

let logger = OnePrintLogger(level: .info)

logger.info("Info message")
logger.debug("Debug message")
logger.warning("Warning message")
logger.error(someError)

// Console output
/*
âšī¸ Info message
đ Debug message
â ī¸ Warning message
đ¨ someError
*/
