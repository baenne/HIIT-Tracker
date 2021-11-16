//
//  UserData.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 15.11.21.
//

import SwiftUI
import Foundation

struct Workout: Codable, Identifiable {
	var id = UUID()
	var rating: Int
	var note: String
	var rounds: Int
	var roundTime: Int
	var pauseTime: Int
	var time: Date
	
	init(rating: Int = 5, note: String = "", rounds: Int = 20, roundTime: Int = 60, pauseTime: Int = 20, time: Date = Date()) {
		self.rating = rating
		self.note = note
		self.rounds = rounds
		self.roundTime = roundTime
		self.pauseTime = pauseTime
		self.time = time
	}
}
class UserData: Codable, Identifiable {
	var id: UUID = UUID()
	var name: String?
	var time: Date
	var workoutList: [Workout]
	var standardRounds: Int?
	var standardRoundTime: Int?
	var standardPauseTime: Int?
	
	init(name: String? = nil,time: Date = Date(), workoutList: [Workout] = [], standardRounds: Int? = nil, standardRoundTime: Int? = nil, standardPauseTime: Int? = nil) {
		self.name = name
		self.time = time
		self.workoutList = workoutList
		self.standardRounds = standardRounds
		self.standardRoundTime = standardRoundTime
		self.standardPauseTime = standardPauseTime
	}
	
	func appendWorkoutList(workout: Workout) {
			self.workoutList.append(workout)
	}
	
	
}

class UserManager: ObservableObject {
	@Published var userData: UserData?
	
	init(userData: UserData? = nil) {
		self.userData = loadUserData()
	}
	
	func saveUserData() {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(userData) {
			let defaults = UserDefaults.standard
			defaults.set(encoded, forKey: "User")
		}
	}
	func loadUserData() -> UserData {
		if let data = UserDefaults.standard.data(forKey: "User") {
			let decoder = JSONDecoder()
			if let loadedUser = try? decoder.decode(UserData.self, from: data) {
				return loadedUser
			} else {
				userData = UserData()
				saveUserData()
				return userData!
			}
		} else {
			userData = UserData()
			saveUserData()
			return userData!
		}
	}
}
