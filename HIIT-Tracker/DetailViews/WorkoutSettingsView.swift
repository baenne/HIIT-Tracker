//
//  WorkoutSettingsView.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 12.11.21.
//
import Combine
import SwiftUI

class WorkoutSettingsViewModel: ObservableObject {
	
}

struct WorkoutSettingsView: View {
	@EnvironmentObject var userManager: UserManager
	
	@State private var editing = false
	@State private var rounds = ""
	@State private var roundTime = ""
	@State private var pauseTime = ""
	
	var body: some View {
		HStack {
			Spacer()
			VStack {
				VStack(alignment: .center) {
					Spacer()
					SettingsTextField(binding: $rounds, descr: "Rounds:", numbers: true)
					SettingsTextField(binding: $roundTime, descr: "Round Time:", numbers: true)
					SettingsTextField(binding: $pauseTime, descr: "Pause Time:", numbers: true)
					Spacer()
					NavigationLink(destination: {
						TimerView(viewModel: TimerViewModel( workout: Workout(rounds: rounds, roundTime: roundTime, pauseTime: pauseTime)))
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
		.onAppear(perform: {
			rounds = userManager.rounds
			roundTime = userManager.roundTime
			pauseTime = userManager.pauseTime
		})
		.background(Color.mainAppColor)
	}
}

struct WorkoutSettingsView_Previews: PreviewProvider {
	static var previews: some View {
		WorkoutSettingsView()
	}
}
