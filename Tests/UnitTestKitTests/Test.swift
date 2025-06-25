//
//  Test.swift
//  UnitTestKit
//
//  Created by Colin Wheeler on 6/24/25.
//

import Testing

struct SampleView: View {
	var body: some View {
		Text("Hello")
	}
}

struct AnotherView: View {
	var body: some View {
		Text("World")
	}
}

struct Test {

    @Test func <#test function name#>() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}
