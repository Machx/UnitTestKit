//
//  Test.swift
//  UnitTestKit
//
//  Created by Colin Wheeler on 6/13/25.
//

import Testing
@testable import UnitTestKit
import os.log

struct LogTests {
	@Test
	func basicLogging() async throws {
		Log.general.debug("Hello from \(logLocation())")
	}
}
