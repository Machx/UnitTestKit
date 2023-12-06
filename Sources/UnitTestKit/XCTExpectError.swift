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

import Foundation
import XCTest

/// Takes a closure that is expected to throw an error, otherwise fails the unit test if no error is thrown.
/// - Parameters:
///   - file: The file where the the failure occurs, the default is the name of the file where this is being invoked from.
///   - line: The line of the file where the failure occurs, the default is the line of the file where this is being invoked from.
///   - block: The closure that must throw an error before completion or fails the unit test.
public func UTKExpectError(_ file: StaticString = #file,
						   _ line: UInt = #line,
						   _ block: () throws -> Void) {
	var errorThrown: Bool = false
	do {
		try block()
	} catch {
		errorThrown = true
	}
	guard errorThrown == false else { return }
	XCTFail("Expected error to be thrown in block, but no error was thrown.",
			file: file,
			line: line)
}

/// Takes a closure that is expected to not throw an error, otherwise fails the unit test if an error is thrown.
/// - Parameters:
///   - block: The closure that must not throw an error before completion or fails the unit test.
public func UTKExpectNoError(_ file: StaticString = #file,
							 _ line: UInt = #line,
							 _ block: () throws -> Void) {
	var errorThrown: Bool = false
	do {
		try block()
	} catch {
		errorThrown = true
	}
	guard errorThrown == true else { return }
	XCTFail("Unexpected error was thrown in block, but no error was expected.",
			file: file,
			line: line)
}
