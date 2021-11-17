//
//  WorkoutListView.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 17.11.21.
//

import SwiftUI

struct WorkoutListView: View {
	@ObservedObject var userManager: UserManager
	var body: some View {
		VStack {
			List {
				ForEach(userManager.workoutList.reversed()) { workout in
					NavigationLink(destination: WorkoutDetailView(workout: workout)) {
						Text("Workout from: \(workout.time.formatted(date: .abbreviated, time: .shortened))")
					}
				}
			}
		}.navigationBarTitle("Past Workouts")
		.navigationBarTitleDisplayMode(.inline)
	}
}

struct WorkoutListView_Previews: PreviewProvider {
	static var previews: some View {
		WorkoutListView(userManager: UserManager())
	}
}
