//
//  Log.swift
//
//
//  Created by Colin Wheeler on 5/6/24.
//

import Foundation
import Konkyo
import os.log

extension Log {
	static let unitTestKit = Logger(subsystem: "com.unittestkit", category: "general")
}
