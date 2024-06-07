///
/// Copyright 2024 Colin Wheeler
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
import Konkyo
import os.log

/// Protocol for being able to specify anything that subclasses from UserDefaults.
public protocol DefaultsProtocol: AnyObject {
	func object(forKey defaultName: String) -> Any?
}

/// Class that is meant to mimic UserDefaults, but not actually
/// write out its contents to the user defaults, instead just
/// keeping everything in memory for better working with unit
/// testing.
public final class MockedDefaults: UserDefaults, DefaultsProtocol {

	// MARK: - Setup

	private var _storage = [String: Any]()

	override init?(suiteName suitename: String?) {
		super.init(suiteName: suitename)
	}

	// MARK: - Getters

	// Default getter.

	public override func object(forKey defaultName: String) -> Any? {
		_storage[defaultName]
	}

	// Specialized getters.

	public override func url(forKey defaultName: String) -> URL? {
		return _storage[defaultName] as? URL
	}

	public override func array(forKey defaultName: String) -> [Any]? {
		return _storage[defaultName] as? [Any]
	}

	public override func dictionary(forKey defaultName: String) -> [String : Any]? {
		return _storage[defaultName] as? [String:Any]
	}

	public override func string(forKey defaultName: String) -> String? {
		return _storage[defaultName] as? String
	}

	public override func stringArray(forKey defaultName: String) -> [String]? {
		return _storage[defaultName] as? [String]
	}

	public override func data(forKey defaultName: String) -> Data? {
		return _storage[defaultName] as? Data
	}

	public override func bool(forKey defaultName: String) -> Bool {
		return _storage[defaultName] as? Bool ?? false
	}

	public override func integer(forKey defaultName: String) -> Int {
		return _storage[defaultName] as? Int ?? 0
	}

	public override func float(forKey defaultName: String) -> Float {
		return _storage[defaultName] as? Float ?? 0.0
	}

	public override func double(forKey defaultName: String) -> Double {
		return _storage[defaultName] as? Double ?? 0.0
	}

	public override func dictionaryRepresentation() -> [String : Any] {
		return _storage
	}

	// MARK: - Setters

	public override func set(_ value: Any?, forKey defaultName: String) {
		_storage[defaultName] = value
	}

	public override func set(_ value: Float, forKey defaultName: String) {
		_storage[defaultName] = value
	}

	public override func set(_ value: Double, forKey defaultName: String) {
		_storage[defaultName] = value
	}

	public override func set(_ value: Int, forKey defaultName: String) {
		_storage[defaultName] = value
	}

	public override func set(_ value: Bool, forKey defaultName: String) {
		_storage[defaultName] = value
	}

	public override func set(_ url: URL?, forKey defaultName: String) {
		_storage[defaultName] = url
	}

	// MARK: - Remove

	public override func removeObject(forKey defaultName: String) {
		_storage.removeValue(forKey: defaultName)
	}

	// MARK: - Other

	// so that nothing actually gets written to the Defaults
	public override func synchronize() -> Bool {
		Log.unitTestKit.debug("Calling this function does nothing. \(#function)")
		return true
	}

	public override class func resetStandardUserDefaults() {
		Log.unitTestKit.debug("Calling this function does nothing. \(#function)")
	}

	// MARK: - Custom Debugging

	/// For debugging purposes this allows you to see all keys registered.
	internal func allRegisteredKeys() -> [String] {
		_storage.keys.sorted()
	}

	public func wipeAllDefaults() {
		_storage.removeAll()
	}
}
