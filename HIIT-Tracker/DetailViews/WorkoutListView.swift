//
//  WorkoutListView.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 17.11.21.
//

import SwiftUI

struct WorkoutListView: View {
	@EnvironmentObject var userManager: UserManager
	var body: some View {
		HStack {
			Spacer()
			ScrollView {
				ForEach(userManager.workouts!.workoutArray.reversed()) { workout in
					NavigationLink(destination: WorkoutDetailView(workout: workout)) {
						HStack {
							Text("Workout from: \(workout.time.formatted(date: .abbreviated, time: .shortened))")
							Image(systemName: "chevron.right")
						}
					}.padding(10)
					.foregroundColor(.textColor)
					.background(Color.secondaryAppColor)
					.cornerRadius(15)
					.shadow(radius: 2)
				}
			}
			Spacer()
		}
		.navigationBarTitle("Past Workouts")
		.navigationBarTitleDisplayMode(.inline)
		.background(Color.mainAppColor)
		
	}
}

struct WorkoutListView_Previews: PreviewProvider {
	static var previews: some View {
		WorkoutListView()
	}
}
