//
///  MockUserDefaultsTests.swift
///  SwiftExperiments
///
///  Created by Colin Wheeler on 4/20/24.
///  Copyright © 2024 Colin Wheeler. All rights reserved.
///

import XCTest
import Konkyo
import os.log
@testable import UnitTestKit

class Person: Codable {
	var name: String
	var age: Int

	init(name: String, age: Int) {
		self.name = name
		self.age = age
	}
}

final class MockUserDefaultsTests: XCTestCase {

	let defaults = MockedDefaults()

	func testRemove() throws {

		// Test Primitive value
		let bool = Bool.random()
		let boolKey = UUID().uuidString
		XCTAssertFalse(defaults.bool(forKey: boolKey))
		defaults.setValue(bool, forKey: boolKey)
		let result = defaults.bool(forKey: boolKey)
		XCTAssertEqual(bool, result)
		defaults.removeObject(forKey: boolKey)
		XCTAssertEqual(false, defaults.bool(forKey: boolKey))

		// Test Object that returns nil when not present
		let objectKey = UUID().uuidString
		let stringValue = "Hello World!"
		XCTAssertNil(defaults.string(forKey: objectKey))
		defaults.setValue(stringValue, forKey: objectKey)
		let objResult = try XCTUnwrap(defaults.string(forKey:objectKey))
		XCTAssertEqual(objResult, stringValue)
		defaults.removeObject(forKey: objectKey)
		XCTAssertNil(defaults.string(forKey: objectKey))
	}

	func testBool() throws {
		let boolKey = UUID().uuidString
		XCTAssertFalse(defaults.bool(forKey: boolKey))
		defaults.setValue(true, forKey: boolKey)
		XCTAssertTrue(defaults.bool(forKey: boolKey))
	}

	func testBool2() {
		let bool2Key = UUID().uuidString
		let myBool: Bool = false
		defaults.set(myBool, forKey: bool2Key)
		XCTAssertFalse(defaults.bool(forKey: bool2Key))
	}

	func testString() throws {
		let stringKey = UUID().uuidString
		XCTAssertNil(defaults.string(forKey: stringKey))
		defaults.setValue("Name", forKey: stringKey)
		XCTAssertEqual("Name", defaults.string(forKey: stringKey))
	}

	func testObject() throws {
		let objectKey = UUID().uuidString
		let objectPerson = Person(name: "Someone", age: 64)
		XCTAssertNil(defaults.object(forKey: objectKey))
		defaults.setValue(objectPerson, forKey: objectKey)
		let person = try XCTUnwrap(defaults.object(forKey: objectKey))
		let objectPerson2 = try XCTUnwrap(person as? Person)
		XCTAssertEqual(objectPerson.name, objectPerson2.name)
		XCTAssertEqual(objectPerson.age, objectPerson2.age)
	}

	func testURL() throws {
		let urlKey = UUID().uuidString
		XCTAssertNil(defaults.url(forKey: urlKey))
		let originalURL = try XCTUnwrap(URL(string: "https://www.apple.com"))
		defaults.setValue(originalURL, forKey: urlKey)
		let defaultsURL = try XCTUnwrap(defaults.url(forKey:urlKey))
		XCTAssertEqual(originalURL, defaultsURL)
	}

	func testURLNil() {
		let url2Key = UUID().uuidString
		XCTAssertNil(defaults.url(forKey: url2Key))
		let url: URL? = nil
		defaults.set(url, forKey: url2Key)
	}

	func testArray() throws {
		let arrayKey = UUID().uuidString
		XCTAssertNil(defaults.array(forKey: arrayKey))
		let original = [1,5,9,6,2,3,10]
		defaults.setValue(original, forKey: arrayKey)
		let defaultsNumbers = try XCTUnwrap(defaults.value(forKey: arrayKey) as? [Int])
		XCTAssertEqual(original, defaultsNumbers)
	}

	func testDictionary() throws {
		let dictionaryKey = UUID().uuidString
		XCTAssertNil(defaults.dictionary(forKey: dictionaryKey))
		let original = [
			"High Score" : 32_000_000,
			"Low Score" : 1_000
		]
		defaults.setValue(original, forKey: dictionaryKey)
		let retrieved = try XCTUnwrap(defaults.dictionary(forKey: dictionaryKey) as? [String:Int])
		XCTAssertEqual(original, retrieved)
	}

	func testStringArray() throws {
		let stringArrayKey = UUID().uuidString
		XCTAssertNil(defaults.stringArray(forKey: stringArrayKey))
		let original = ["A","B","C"]
		defaults.setValue(original, forKey: stringArrayKey)
		let retrieved = try XCTUnwrap(defaults.stringArray(forKey: stringArrayKey))
		XCTAssertEqual(original, retrieved)
	}

	func testData() throws {
		let dataKey = UUID().uuidString
		XCTAssertNil(defaults.data(forKey: dataKey))
		let original = "Hello".data(using: .utf8)
		defaults.set(original, forKey: dataKey)
		let result = try XCTUnwrap(defaults.data(forKey: dataKey))
		XCTAssertEqual(original, result)
	}

	func testInteger() throws {
		let integerKey = UUID().uuidString
		// integerForKey always returns an integer so we compare against 0 (default value)
		XCTAssertEqual(0, defaults.integer(forKey: integerKey))
		let original = 10
		defaults.set(original, forKey: integerKey)
		let result = try XCTUnwrap(defaults.integer(forKey:integerKey))
		XCTAssertEqual(original, result)
	}

	func testFloat() throws {
		let floatKey = UUID().uuidString
		// floatForKey always returns a float, so we compare against 0 (default value)
		XCTAssertEqual(Float(0), defaults.float(forKey: floatKey))
		let original = Float(3.1415)
		defaults.set(original, forKey: floatKey)
		let result = try XCTUnwrap(defaults.float(forKey:floatKey))
		XCTAssertEqual(original, result)
	}

	func testDouble() throws {
		let doubleKey = UUID().uuidString
		// doubleForKey always returns a double, so we compare against 0 (default value)
		XCTAssertEqual(Double(0), defaults.double(forKey: doubleKey))
		let original = Double(3.1415)
		defaults.set(original, forKey: doubleKey)
		let result = try XCTUnwrap(defaults.double(forKey:doubleKey))
		XCTAssertEqual(original, result)
	}

	func testDictionaryRepresentation() throws {
		let randomKey = UUID().uuidString
		XCTAssertNil(defaults.string(forKey: randomKey))
		defaults.set("test", forKey: randomKey)
		let dictRep = defaults.dictionaryRepresentation()
		XCTAssertTrue(dictRep.keys.contains(randomKey))
	}

	func testSynchronize() {
		XCTAssertTrue(defaults.synchronize())
	}

	func testReset() {
		// This does nothing
		MockedDefaults.resetStandardUserDefaults()
	}

	func testOverwriteValue() {
		let key = UUID().uuidString
		defaults.set("Original", forKey: key)
		defaults.set("Updated", forKey: key)
		XCTAssertEqual(defaults.string(forKey: key), "Updated")
	}
}
