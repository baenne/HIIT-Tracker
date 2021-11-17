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
	var rounds: String
	var roundTime: String
	var pauseTime: String
	var time: Date
	
	init(rating: Int = 5, note: String = "", rounds: String = "20", roundTime: String = "60", pauseTime: String = "20", time: Date = Date()) {
		self.rating = rating
		self.note = note
		self.rounds = rounds
		self.roundTime = roundTime
		self.pauseTime = pauseTime
		self.time = time
	}
}
struct UserData: Codable, Identifiable {
	var id: UUID = UUID()
	var name: String
	var time: Date
	var workoutList: [Workout]
	var standardRounds: String
	var standardRoundTime: String
	var standardPauseTime: String
	
	init(name: String = "",time: Date = Date(), workoutList: [Workout] = [], standardRounds: String = "5", standardRoundTime: String = "3", standardPauseTime: String = "2") {
		self.name = name
		self.time = time
		self.workoutList = workoutList
		self.standardRounds = standardRounds
		self.standardRoundTime = standardRoundTime
		self.standardPauseTime = standardPauseTime
	}
	
	mutating func appendWorkoutList(workout: Workout) {
			self.workoutList.append(workout)
	}
	
	
}

class UserManager: ObservableObject {
	@Published var userData: UserData? {
		didSet {
			saveUserData()
		}
	}
	@Published var name: String {
		didSet {
			userData?.name = name
		}
	}
	
	@Published var workoutList: [Workout] {
		didSet {
			userData?.workoutList = workoutList
		}
	}
	@Published var rounds: String {
		didSet {
			userData?.standardRounds = rounds
		}
	}
	@Published var roundTime: String {
		didSet {
			userData?.standardRoundTime = roundTime
		}
	}
	
	@Published var pauseTime: String {
		didSet {
			userData?.standardPauseTime = pauseTime
		}
	}
	
	init(userData: UserData? = nil, name: String = "", workoutList: [Workout] = [], rounds: String = "5", roundTime: String = "3", pauseTime: String = "2") {
		self.userData = userData
		self.name = name
		self.workoutList = workoutList
		self.rounds = rounds
		self.roundTime = roundTime
		self.pauseTime = pauseTime
		
		self.userData = loadUserData()
	}
	
	func saveUserData() {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(userData) {
			let defaults = UserDefaults.standard
			defaults.set(encoded, forKey: "User")
		} else {
			print("error: encoding")
		}
	}
	func loadUserData() -> UserData {
		if let data = UserDefaults.standard.data(forKey: "User") {
			let decoder = JSONDecoder()
			if let loadedUser = try? decoder.decode(UserData.self, from: data) {
				self.name = loadedUser.name
				self.workoutList = loadedUser.workoutList
				self.rounds = loadedUser.standardRounds
				self.roundTime = loadedUser.standardRoundTime
				self.pauseTime = loadedUser.standardPauseTime
				return loadedUser
			} else {
				userData = UserData()
				self.name = userData?.name ?? ""
				self.workoutList = userData?.workoutList ?? [Workout]()
				self.rounds = userData?.standardRounds ?? ""
				self.roundTime = userData?.standardRoundTime ?? ""
				self.pauseTime = userData?.standardPauseTime ?? ""
				return userData!
			}
		} else {
			userData = UserData()
			self.name = userData?.name ?? ""
			self.workoutList = userData?.workoutList ?? [Workout]()
			self.rounds = userData?.standardRounds ?? ""
			self.roundTime = userData?.standardRoundTime ?? ""
			self.pauseTime = userData?.standardPauseTime ?? ""
			return userData!
		}
	}
}
