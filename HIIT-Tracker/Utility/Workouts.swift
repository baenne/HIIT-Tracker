//
//  Workouts.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 18.11.21.
//

import Foundation

struct Workout: Codable, Identifiable {
	var id = UUID()
	var rating: Int
	var note: String
	var rounds: String
	var roundTime: String
	var pauseTime: String
	var time: Date
	
	init(rating: Int = 3, note: String = "", rounds: String = "20", roundTime: String = "60", pauseTime: String = "20", time: Date = Date()) {
		self.rating = rating
		self.note = note
		self.rounds = rounds
		self.roundTime = roundTime
		self.pauseTime = pauseTime
		self.time = time
	}
}

struct Workouts: Codable, Identifiable {
	var id = UUID()
	var workoutArray: [Workout]
	
	init(workoutArray: [Workout] = [Workout]()) {
		self.workoutArray = workoutArray
	}
	
	mutating func appendWorkoutArray(workout: Workout) {
			self.workoutArray.append(workout)
	}
}
