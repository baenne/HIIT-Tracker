//
//  HIIT_TrackerApp.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 12.11.21.
//

import SwiftUI

@main
struct HIIT_TrackerApp: App {
	@ObservedObject var userManager = UserManager()

    var body: some Scene {
        WindowGroup {
			ContentView()
				.environmentObject(userManager)
        }
    }
}
