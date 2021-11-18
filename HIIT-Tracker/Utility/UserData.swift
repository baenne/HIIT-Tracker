//
//  UserData.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 15.11.21.
//

import SwiftUI
import Foundation

struct UserData: Codable, Identifiable {
	var id: UUID = UUID()
	var name: String
	var time: Date
	var standardRounds: String
	var standardRoundTime: String
	var standardPauseTime: String
	
	init(name: String = "",time: Date = Date(), standardRounds: String = "5", standardRoundTime: String = "3", standardPauseTime: String = "2") {
		self.name = name
		self.time = time
		self.standardRounds = standardRounds
		self.standardRoundTime = standardRoundTime
		self.standardPauseTime = standardPauseTime
	}
}
