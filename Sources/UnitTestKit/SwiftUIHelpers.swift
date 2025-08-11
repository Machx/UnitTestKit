///
/// Copyright 2025 Colin Wheeler
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

import SwiftUI

public extension View {
	/// Returns a bool indicating if a referenced view is of a given type.
	/// - Parameter type: The type to check if the view is this given type.
	/// - Returns: True if the view is the given type, otherwise returns false.
	func isOfType<T>(_ type: T.Type) async -> Bool {
		return self is T
	}
}
