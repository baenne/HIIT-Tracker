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
	}
}

struct WorkoutSettingsView: View {
	@ObservedObject var viewModel: WorkoutSettingsViewModel
	
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
					SettingsTextField(binding: $viewModel.userManager.rounds, descr: "Rounds:", numbers: true)
					SettingsTextField(binding: $viewModel.userManager.roundTime, descr: "Round Time:", numbers: true)
					SettingsTextField(binding: $viewModel.userManager.pauseTime, descr: "Pause Time:", numbers: true)
					Spacer()
					NavigationLink(destination: {
						TimerView(viewModel: TimerViewModel(userManager: viewModel.userManager, workout: Workout(rounds: viewModel.userManager.rounds, roundTime: viewModel.userManager.roundTime, pauseTime: viewModel.userManager.pauseTime)))
					}){
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
