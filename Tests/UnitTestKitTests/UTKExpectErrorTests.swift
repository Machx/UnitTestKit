///
/// Copyright 2023 Colin Wheeler
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import XCTest
import UnitTestKit
import Testing

@Suite("UTKExpectErrorTests")
struct UTKExpectErrorTests {
	@Test func testExpectThrowError() async throws {
		struct MyError: Error {}
		try UTKExpectError {
			throw MyError()
		}
	}

	@Test func testExpectNoError() async throws {
		try UTKExpectNoError {
			print("Hello")
		}
	}

	@Test func testExpectErrorFailure() async throws {
		var failed = false
		do {
			try UTKExpectError {
				print("Hello")
			}
		} catch {
			failed = true
		}
		#expect(failed == true)
	}

	@Test func testExpectNoErrorFailure() async throws {
		var failed = false
		do {
			try UTKExpectNoError {
				throw NSError(domain: "", code: 0, userInfo: nil)
			}
		} catch {
			failed = true
		}
		#expect(failed == true)
	}
}

//final class UTKExpectErrorTests: XCTestCase {
//
//	enum ExpectError: Error {
//		case exampleError
//	}
//
//
//	func testExpectErrorThrows() throws {
//		UTKExpectError {
//			throw ExpectError.exampleError
//		}
//	}
//
//	func testExpectNoError() throws {
//		XCTExpectFailure("Code block throws an error, which should trigger UTKExpectNoError to fail.")
//
//		UTKExpectNoErrorXCT {
//			throw ExpectError.exampleError
//		}
//	}
//
//	func testExpectNoErrorNoThrows() throws {
//		UTKExpectNoErrorXCT {
//			print("Hello World!")
//		}
//	}
//}
