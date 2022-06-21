# OneLogger

Simple swift logger that can be extended with custom loggers, that for example send the logging to a web service.

Uses four log levels: `info`, `debug`, `warning` and `error`.

Basic `print` and `file` loggers are available by default.

Used in [OneNetwork](https://github.com/enhorn/OneNetwork).

Example usage:

```swift
import OneLogger

struct MyView: View {

    private let logger: OneLogger = OnePrintLogger(level: .debug)

    var body: some View {
        Button("Print statements") {
            logger.info("Info log message") // Not printed due to the logger being at `.debug` level.
            logger.debug("Debug log message")
        }
    }

}

```
