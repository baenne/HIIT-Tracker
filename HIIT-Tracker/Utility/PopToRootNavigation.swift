//
//  PopToRootNavigation.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 16.11.21.
//

import Foundation
import SwiftUI


struct RootPresentationModeKey: EnvironmentKey {
	static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
	var rootPresentationMode: Binding<RootPresentationMode> {
		get { return self[RootPresentationModeKey.self] }
		set { self[RootPresentationModeKey.self] = newValue }
	}
}

typealias RootPresentationMode = Bool

extension RootPresentationMode {
	
	public mutating func dismiss() {
		self.toggle()
	}
}


class NavigationHelper: ObservableObject {
	@Published var selection: String? = nil
}
