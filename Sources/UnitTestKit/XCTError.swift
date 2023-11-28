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

public func XCTExpectError(_ file: StaticString = #file,
						   _ line: UInt = #line,
						   _ block: () throws -> Void) {
	var errorThrown: Bool = false
	do {
		try block()
	} catch {
		errorThrown = true
	}
	guard errorThrown == false else { return }
	XCTFail("Expected Error to be thrown in block but no error was thrown.\(file):\(line)",
			file: file,
			line: line)
}

public func XCTExpectNoError(_ file: StaticString = #file,
							 _ line: UInt = #line,
							 _ block: () throws -> Void) {
	var errorThrown: Bool = false
	do {
		try block()
	} catch {
		errorThrown = true
	}
	guard errorThrown == true else { return }
	XCTFail("Expected Error to be thrown in block but no error was thrown.\(file):\(line)",
			file: file,
			line: line)
}
