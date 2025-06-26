//
//  Test.swift
//  UnitTestKit
//
//  Created by Colin Wheeler on 6/24/25.
//

import Testing
import SwiftUI
import UnitTestKit

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


@Suite("SwiftUIHelperTests")
struct SwiftUIHelperTests {
	@Test
	func isofTypeTest() async throws {
		let view = SampleView()
		#expect(await view.isOfType(SampleView.self))
	}

	func isNotOfTypeTest() async throws {
		let view = SampleView()
		#expect(await !view.isOfType(Text.self))
	}
}
