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

		UTKExpectError {
			print("Hello World!")
		}
	}

	func testExpectErrorThrows() throws {
		UTKExpectError {
			throw ExpectError.exampleError
		}
	}

	func testExpectNoError() throws {
		XCTExpectFailure("Code block does not throw which should trigger XCTExpectError to fail.")

		UTKExpectNoError {
			throw ExpectError.exampleError
		}
	}

	func testExpectNoErrorNoThrows() throws {
		UTKExpectNoError {
			print("Hello World!")
		}
	}
}
