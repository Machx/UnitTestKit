//
//  File.swift
//  UnitTestKit
//
//  Created by Colin Wheeler on 6/22/25.
//

import SwiftUI

public extension View {
	/// Returns a bool indicating if a referenced view is of a given type.
	/// - Parameter type: The type to check if the view is this given type.
	/// - Returns: True if the view is the given type, otherwise returns false.
	func isOfType<T>(_ type: T.Type) -> Bool {
		return self is T
	}
}
