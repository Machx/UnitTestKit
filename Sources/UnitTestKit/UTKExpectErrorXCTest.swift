//
//  File.swift
//  UnitTestKit
//
//  Created by Colin Wheeler on 6/12/25.
//

import Foundation
import XCTest

/// Takes a closure that is expected to throw an error, fails the unit test if no error is thrown in XCTestCases.
///
/// ```swift update the examples with try await and make sure everything works
/// UTKExpectErrorXCT {
///     try funcThatShouldThrowError()
///     try anotherFuncThatShouldThrowAnError()
/// }
/// ```
///
/// - Parameters:
///   - file: The file where the the failure occurs, the default is the name of the file where this is being invoked from.
///   - line: The line of the file where the failure occurs, the default is the line of the file where this is being invoked from.
///   - block: The closure that must throw an error before completion or fails the unit test.
public func UTKExpectErrorXCT(_ file: StaticString = #file,
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
			file: (file),
			line: line)
}

/// Takes a closure that is expected to not throw an error, fails the unit test if an error is thrown in XCTestCases.
///
/// ```swift
/// UTKExpectNoErrorXCT {
///     try funcThatShouldNotThrowError()
///     try anotherFuncThatShouldNotThrowAnError()
/// }
/// ```
///
/// - Parameters:
///   - file: The file where the the failure occurs, the default is the name of the file where this is being invoked from.
///   - line: The line of the file where the failure occurs, the default is the line of the file where this is being invoked from.
///   - block: The closure that must not throw an error before completion or fails the unit test.
public func UTKExpectNoErrorXCT(_ file: StaticString = #file,
							 _ line: UInt = #line,
							 _ block: () throws -> Void) {
	var errorThrown: Bool = false
	var errorDescription: String?
	do {
		try block()
	} catch {
		errorDescription = error.localizedDescription
		errorThrown = true
	}
	guard errorThrown == true else { return }
	let errorMessageDescription = errorDescription ?? "unknown-error"
	XCTFail("Unexpected error \(errorMessageDescription) was thrown in block, but no error was expected.",
			file: (file),
			line: line)
}
