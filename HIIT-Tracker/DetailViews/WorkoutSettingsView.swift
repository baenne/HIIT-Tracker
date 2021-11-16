//
//  WorkoutSettingsView.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 12.11.21.
//
import Combine
import SwiftUI

class WorkoutSettingsViewModel: ObservableObject {
	@ObservedObject var userManager: UserManager
	
	init(userManager: UserManager, rounds: String = "", roundTime: String = "", pauseTime: String = "") {
		self.userManager = userManager
		self.rounds = String(userManager.userData?.standardRounds ?? 20)
		self.roundTime = String(userManager.userData?.standardRoundTime ?? 60)
		self.pauseTime = String(userManager.userData?.standardPauseTime ?? 20)
	}
	
	@Published
	var rounds: String
	@Published
	var roundTime: String
	@Published
	var pauseTime: String
}

struct WorkoutSettingsView: View {
	@ObservedObject var viewModel: WorkoutSettingsViewModel
	@EnvironmentObject var navigationHelper: NavigationHelper
	
	init(viewModel: WorkoutSettingsViewModel) {
		self.viewModel = viewModel
	}
	@State private var editing = false
	
	var body: some View {
		HStack {
			Spacer()
			VStack {
				VStack(alignment: .center) {
					Spacer()
					SettingsTextField(binding: $viewModel.rounds, descr: "Rounds:", numbers: true)
					SettingsTextField(binding: $viewModel.roundTime, descr: "Round Time:", numbers: true)
					SettingsTextField(binding: $viewModel.pauseTime, descr: "Pause Time:", numbers: true)
					Spacer()
					NavigationLink(destination: AnyView(TimerView(viewModel: TimerViewModel(userManager: viewModel.userManager, workout: Workout(rounds: Int(viewModel.rounds) ?? 10, roundTime: Int(viewModel.roundTime) ?? 5, pauseTime: Int(viewModel.pauseTime) ?? 5)))), tag: "Timer", selection: $navigationHelper.selection){
						Spacer()
						Text("Start")
							.foregroundColor(.textColor)
						Spacer()
					}
					.padding()
					.background(Color.secondaryAppColor)
					.cornerRadius(15)
					.shadow(radius: 2)
				}.frame(width: 250)

				Spacer()
			}.padding(.vertical, 20)
			Spacer()
		}
		.navigationTitle("Workout Preparation")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct WorkoutSettingsView_Previews: PreviewProvider {
	static var previews: some View {
		WorkoutSettingsView(viewModel: WorkoutSettingsViewModel(userManager: UserManager()))
	}
}
