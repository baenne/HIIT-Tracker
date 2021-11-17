//
//  TimerView.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 12.11.21.
//

import SwiftUI

class TimerViewModel: ObservableObject {
	@ObservedObject var userManager: UserManager
	var workout: Workout
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	@Published
	var tempRoundTime: Int
	@Published
	var tempPauseTime: Int
	@Published
	var tempRounds: Int

	init(userManager: UserManager, workout: Workout) {
		self.userManager = userManager
		self.workout = workout
		self.tempRounds = Int(workout.rounds) ?? 5
		self.tempRoundTime = Int(workout.roundTime) ?? 3
		self.tempPauseTime = Int(workout.pauseTime) ?? 2
	}

	var displayTime: Int {
		if tempRoundTime > 0, tempPauseTime > 0 {
			return tempRoundTime
		} else {
			if tempRoundTime == 0, tempPauseTime > 0 {
				return tempPauseTime
			} else {
				return 0
			}
		}
	}

	var roundsOrPause: String {
		if tempRoundTime == 0, tempPauseTime > 0, tempRounds > 0 {
			return "Pause"
		} else {
			if tempRoundTime > 0 {
				return "\(tempRounds)"
			} else {
				return "Pause"
			}
		}
	}
}

struct TimerView: View {
	@ObservedObject var viewModel: TimerViewModel
	@Environment(\.presentationMode) var presentationMode
	var body: some View {
		VStack {
			finishScreen
		}.navigationTitle("Workout")
	}

	var finishScreen: some View {
		Group {
			if viewModel.tempRounds == 0 {
				VStack {
					Text("You finished your Workout \(viewModel.userManager.name)")
					Button(action: {
						self.presentationMode.wrappedValue.dismiss()
					})
					{Text("Finish")}
				}
			} else {
				VStack {
					Text("\(viewModel.roundsOrPause)")
					Text("\(viewModel.displayTime)")
				}.onReceive(viewModel.timer) { _ in
					if viewModel.tempRoundTime > 0 {
						viewModel.tempRoundTime -= 1
					} else {
						if viewModel.tempRoundTime == 0, viewModel.tempPauseTime > 0 {
							viewModel.tempPauseTime -= 1
						} else {
							if viewModel.tempRounds > 0 {
								viewModel.tempRoundTime = Int(viewModel.workout.roundTime) ?? 4
								viewModel.tempPauseTime = Int(viewModel.workout.pauseTime) ?? 3
								viewModel.tempRounds -= 1
							}
						}
					}
				}
			}
		}
	}
}

struct TimerView_Previews: PreviewProvider {
	static var viewModel = TimerViewModel(userManager: UserManager() ,workout: Workout())
	static var previews: some View {
		TimerView(viewModel: TimerView_Previews.viewModel)
	}
}
