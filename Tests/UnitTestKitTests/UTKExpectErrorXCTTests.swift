//
//  UTKExpectErrorXCTTests.swift
//  UnitTestKit
//
//  Created by Colin Wheeler on 6/5/25.
//

import XCTest
import UnitTestKit
import Testing

final class UTKExpectErrorXCTTests: XCTestCase {

	enum ExpectError: Error {
		case exampleError
	}

	func testExpectThrowError() throws {
		XCTExpectFailure("Code block does not throw which should trigger UTKExpectError to fail.")

		UTKExpectErrorXCT {
			print("Hello World!")
		}
	}

	func testExpectErrorThrows() throws {
		UTKExpectError {
			throw ExpectError.exampleError
		}
	}

	func testExpectNoError() throws {
		XCTExpectFailure("Code block throws an error, which should trigger UTKExpectNoError to fail.")

		UTKExpectNoErrorXCT {
			throw ExpectError.exampleError
		}
	}

	func testExpectNoErrorNoThrows() throws {
		UTKExpectNoErrorXCT {
			print("Hello World!")
		}
	}
}
