//
//  UserManager.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 18.11.21.
//

import Foundation


class UserManager: ObservableObject {
	@Published var userData: UserData?
	@Published var workouts: Workouts?
	var name: String {
		userData?.name ?? ""
	}
	var rounds: String {
			return userData?.standardRounds ?? ""
	}
	var roundTime: String {
			return userData?.standardRoundTime ?? ""
	}
	
	var pauseTime: String {
			return userData?.standardPauseTime ?? ""
	}
	
	init(userData: UserData? = nil, workouts: Workouts? = nil) {
		self.userData = userData
		self.workouts = workouts
		
		self.userData = loadUserData()
		self.workouts = loadWorkouts()
	}
	
	func saveWorkouts() {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(workouts) {
			let defaults = UserDefaults.standard
			defaults.set(encoded, forKey: "Workouts")
		} else {
			print("error: encoding")
		}
	}
	
	func loadWorkouts() -> Workouts{
		if let data = UserDefaults.standard.data(forKey: "Workouts") {
			let decoder = JSONDecoder()
			if let loadedWorkouts = try? decoder.decode(Workouts.self, from: data) {
				return loadedWorkouts
			} else {
				workouts = Workouts()
				return workouts!
			}
		} else {
			workouts = Workouts()
			return workouts!
		}
	}
	
	func saveUserData(name: String = "", standardRounds: String = "", standardRoundTime: String = "", standardPauseTime: String = "") {
		if !name.isEmpty && !standardRounds.isEmpty && !standardRoundTime.isEmpty && !standardPauseTime.isEmpty {
			userData?.name = name
			userData?.standardRounds = standardRounds
			userData?.standardRoundTime = standardRoundTime
			userData?.standardPauseTime = standardPauseTime
		}
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(userData) {
			let defaults = UserDefaults.standard
			defaults.set(encoded, forKey: "UserData")
		} else {
			print("error: encoding")
		}
	}
	func loadUserData() -> UserData {
		if let data = UserDefaults.standard.data(forKey: "UserData") {
			let decoder = JSONDecoder()
			if let loadedUser = try? decoder.decode(UserData.self, from: data) {
				return loadedUser
			} else {
				userData = UserData()
				return userData!
			}
		} else {
			userData = UserData()
			return userData!
		}
	}
}
