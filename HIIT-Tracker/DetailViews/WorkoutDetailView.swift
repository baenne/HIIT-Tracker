//
//  WorkoutDetailView.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 17.11.21.
//

import SwiftUI

struct WorkoutDetailView: View {
	var workout: Workout
	var offImage: Image?
	var onImage = Image(systemName: "star.fill")
	var offColor = Color.gray
	var onColor = Color.yellow
	var label = "Rating"
	var maximumRating = 5
	var body: some View {
		Text("\(workout.time.formatted(date: .abbreviated, time: .shortened))")
		HStack {
			if label.isEmpty == false {
				Text(label)
			}
			ForEach(1 ..< maximumRating + 1) { number in
				self.image(for: number)
					.foregroundColor(number > self.workout.rating ? self.offColor : self.onColor)
			}
		}
		Text("\(workout.note)")
	}
	func image(for number: Int) -> Image {
		if number > workout.rating {
			return offImage ?? onImage
		} else {
			return onImage
		}
	}
}



struct WorkoutDetailView_Previews: PreviewProvider {
	static var previews: some View {
		WorkoutDetailView(workout: Workout())
	}
}
