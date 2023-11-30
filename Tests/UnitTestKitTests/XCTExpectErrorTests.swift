//
//  XCTExpectErrorTests.swift
//  
//
//  Created by Colin Wheeler on 11/28/23.
//

import XCTest
import UnitTestKit

final class XCTExpectErrorTests: XCTestCase {

	enum ExpectError: Error {
		case exampleError
	}

	func testExpectThrowError() throws {
		XCTExpectFailure("Code block does not throw which should trigger XCTExpectError to fail.")

		XCTExpectError {
			print("Hello")
		}
	}

	func testExpectNoError() throws {
		XCTExpectFailure("Code block does not throw which should trigger XCTExpectError to fail.")

		XCTExpectNoError {
			throw ExpectError.exampleError
		}
	}
}
