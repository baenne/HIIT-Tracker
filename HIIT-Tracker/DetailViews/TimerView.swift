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
	@Published
	var rating: Int {
		didSet {
			workout.rating = rating
		}
	}
	@Published
	var note: String {
		didSet {
			workout.note = note
		}
	}

	init(userManager: UserManager, workout: Workout, rating: Int = 3, note: String = "") {
		self.userManager = userManager
		self.workout = workout
		self.tempRounds = Int(workout.rounds) ?? 5
		self.tempRoundTime = Int(workout.roundTime) ?? 3
		self.tempPauseTime = Int(workout.pauseTime) ?? 2
		self.rating = rating
		self.note = note
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
		GeometryReader { proxy in
			HStack {
				VStack(alignment: .center, spacing: 15) {
				finishScreen(width: proxy.size.width)
				}.navigationTitle("Workout")
					.frame(width: proxy.size.width - 100)
			}.padding(.horizontal, 50)
		}
	}

	func finishScreen(width: CGFloat) -> some View {
		Group {
			Spacer()
			if viewModel.tempRounds == 0 {
				VStack {
					Spacer()
					Text("You finished your Workout \(viewModel.userManager.name)")
					Text("Rate your workout")
					HStack {
						RatingView(rating: $viewModel.rating)
					}
					TextEditor(text: $viewModel.note)
						.frame(width: width - 150, height: 150)
					Button(action: {
						viewModel.userManager.workoutList.append(viewModel.workout)
						viewModel.userManager.saveUserData()
						self.presentationMode.wrappedValue.dismiss()
					})
					{Text("Finish")}
					Spacer()
				}
			} else {
				VStack {
					Spacer()
					Text("\(viewModel.roundsOrPause)")
					Text("\(viewModel.displayTime)")
					Spacer()
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
			Spacer()
		}
	}
}

struct RatingView: View {
	@Binding var rating: Int
	var label = ""
	var maximumRating = 5
	var offImage: Image?
	var onImage = Image(systemName: "star.fill")
	var offColor = Color.gray
	var onColor = Color.yellow
	
	var body: some View {
		HStack {
			if label.isEmpty == false {
				Text(label)
			}
			ForEach(1..<maximumRating + 1) { number in
				self.image(for: number)
					.foregroundColor(number > self.rating ? self.offColor : self.onColor)
					.onTapGesture {
						self.rating = number
				}
			}
		}
	}
	func image(for number: Int) -> Image {
		if number > rating {
			return offImage ?? onImage
		} else {
			return onImage
		}
	}
}

struct TimerView_Previews: PreviewProvider {
	static var viewModel = TimerViewModel(userManager: UserManager() ,workout: Workout())
	static var previews: some View {
		TimerView(viewModel: TimerView_Previews.viewModel)
	}
}
