//
//  File.swift
//  
//
//  Created by Colin Wheeler on 11/27/23.
//

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
