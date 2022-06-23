import Foundation
import XCTest
@testable import OneLogger

final class OneLoggerTests: XCTestCase {

    func testPrintLogger() {
		var logger = OnePrintLogger(level: .info)
		test(logger: &logger)
    }

	func testFileLogger() {
		var logger = OneFileLogger(level: .info, fileURL: .fileURL)
		test(logger: &logger)
	}

	func testErrorFormatter() throws {
		let logger = OneFileLogger(level: .info, fileURL: .fileURL)

		logger.errorFormatters = [
			SomeTestFormatter(),
			AnotherTestFormatter()
		]

		try? FileManager.default.removeItem(at: .fileURL)

		XCTAssertEqual(String.logContent(), "")

		logger.error(TestError.someError)
		logger.error(TestError.anotherError)

		let currentLog = String.logContent()
		let lines = currentLog.split(separator: "\n")

		XCTAssertEqual(lines.count, 2, "Should only contain two lines")

		XCTAssert(lines[0].contains("This was .someError"), "First line shold be from the first formatter.")
		XCTAssert(lines[1].contains("This was .anotherError"), "Second line shold be from the second formatter.")

		try? FileManager.default.removeItem(at: .fileURL)
	}

}

private extension OneLoggerTests {

	func test<Logger: OneLogger>(logger: inout Logger) {
		XCTAssert(logger.shouldLogInfo, "Info should be printed")
		XCTAssert(logger.shouldLogDebug, "Debug should be printed")
		XCTAssert(logger.shouldLogWarning, "Warning should be printed")
		XCTAssert(logger.shouldLogError, "Info should be printed")

		logger.level = .debug

		XCTAssertFalse(logger.shouldLogInfo, "Info should NOT be printed")
		XCTAssert(logger.shouldLogDebug, "Debug should be printed")
		XCTAssert(logger.shouldLogWarning, "Warning should be printed")
		XCTAssert(logger.shouldLogError, "Info should be printed")

		logger.level = .warning

		XCTAssertFalse(logger.shouldLogInfo, "Info should NOT be printed")
		XCTAssertFalse(logger.shouldLogDebug, "Debug should NOT be printed")
		XCTAssert(logger.shouldLogWarning, "Warning should be printed")
		XCTAssert(logger.shouldLogError, "Info should be printed")

		logger.level = .error

		XCTAssertFalse(logger.shouldLogInfo, "Info should NOT be printed")
		XCTAssertFalse(logger.shouldLogDebug, "Debug should NOT be printed")
		XCTAssertFalse(logger.shouldLogWarning, "Warning should NOT be printed")
		XCTAssert(logger.shouldLogError, "Info should be printed")
	}

}

// MARK: - Support -

extension String {

	static func logContent() -> String {
		do {
			return String(
				data: try Data(contentsOf: .fileURL),
				encoding: .utf8
			) ?? ""
		} catch _ {
			return ""
		}
	}

}

private extension URL {

	static var fileURL: URL {
		documentsDirectory.appendingPathComponent("TestLog.log")
	}

	static var documentsDirectory: URL {
		FileManager.default.urls(
			for: .documentDirectory,
			in: .userDomainMask
		)[0]
	}

}

enum TestError: Error, CaseIterable {
	case someError
	case anotherError
}

class SomeTestFormatter: OneLoggerErrorFormatter {

	func format(_ error: Error) -> String? {
		guard
			let testError = error as? TestError,
			testError == .someError
		else { return nil }
		return "This was .someError"
	}

}

class AnotherTestFormatter: OneLoggerErrorFormatter {

	func format(_ error: Error) -> String? {
		guard
			let testError = error as? TestError,
			testError == .anotherError
		else { return nil }
		return "This was .anotherError"
	}

}
