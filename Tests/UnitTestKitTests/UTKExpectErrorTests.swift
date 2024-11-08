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

@Test func expectThrowError() async throws {
	UTKExpectError {
		print("Hello World!")
	}
}

final class UTKExpectErrorTests: XCTestCase {

	enum ExpectError: Error {
		case exampleError
	}

	func testExpectThrowError() throws {
		XCTExpectFailure("Code block does not throw which should trigger UTKExpectError to fail.")

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
		XCTExpectFailure("Code block throws an error, which should trigger UTKExpectNoError to fail.")

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
