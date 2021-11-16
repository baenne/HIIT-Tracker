//
//  MainMenuView.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 12.11.21.
//

import Foundation
import SwiftUI

struct MainMenuView: View {
	
	@ObservedObject var userManager: UserManager
	
    var body: some View {
		VStack {
			VStack {
				MainMenuButtonStyle(view: AnyView(WorkoutSettingsView(viewModel: WorkoutSettingsViewModel(userManager: userManager))), buttonText: "Start Workout", tag: "WorkoutSettings")
				MainMenuButtonStyle(view: AnyView(SettingsView(viewModel: SettingsViewModel(userManager: userManager))), buttonText: "Settings", tag: "Settings")
				MainMenuButtonStyle(view: AnyView(SettingsView(viewModel: SettingsViewModel(userManager: userManager))), buttonText: "Profile", tag: "Profile")
			}
			.frame(width: 150)
		}.navigationBarHidden(true)
    }
}

struct MainMenuButtonStyle: View {
	@EnvironmentObject var navigationHelper: NavigationHelper
	
	let color: Color
	let backgroundColor: Color
	let cornerRadius: CGFloat
	let shadowRadius: CGFloat
	let view : AnyView
	let buttonText: String
	let tag: String
	
	init(color: Color = .textColor, backgroundColor: Color = .secondaryAppColor, cornerRadius: CGFloat = 15, shadowRadius: CGFloat = 2,  view : AnyView = AnyView(EmptyView()), buttonText: String = "Placeholder", tag: String = "") {
		self.color = color
		self.backgroundColor = backgroundColor
		self.cornerRadius = cornerRadius
		self.shadowRadius = shadowRadius
		self.view = view
		self.buttonText = buttonText
		self.tag = tag
	}
	var body: some View {
		
		NavigationLink( destination: view, tag: tag , selection: $navigationHelper.selection) {
			Spacer()
			Text(buttonText)
				.foregroundColor(color)
			Spacer()
		}
		.padding()
		.background(backgroundColor)
		.cornerRadius(cornerRadius)
		.shadow(radius: shadowRadius)
		
		
	}
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
		MainMenuView(userManager: UserManager())
    }
}
