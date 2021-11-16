//
//  SettingsView.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 12.11.21.
//
import Combine
import SwiftUI

class SettingsViewModel: ObservableObject {
	@ObservedObject var userManager: UserManager
	
	init(userManager: UserManager,name: String = "", rounds: String = "", roundTime: String = "", pauseTime: String = "") {
		self.userManager = userManager
		self.name = userManager.userData?.name ?? ""
		self.rounds = String(userManager.userData?.standardRounds ?? 20)
		self.roundTime = String(userManager.userData?.standardRoundTime ?? 60)
		self.pauseTime = String(userManager.userData?.standardPauseTime ?? 20)
	}
	@Published
	var name: String {
		didSet {
			userManager.userData?.name = name
		}
	}
	
	@Published
	var rounds: String {
		didSet {
			userManager.userData?.standardRounds = Int(rounds)
		}
	}
	@Published
	var roundTime: String {
		didSet {
			userManager.userData?.standardRoundTime = Int(roundTime)
		}
	}
	@Published
	var pauseTime: String {
		didSet {
			userManager.userData?.standardPauseTime = Int(pauseTime)
		}
	}
}

struct SettingsView: View {
	@ObservedObject var viewModel: SettingsViewModel
	
	init(viewModel: SettingsViewModel) {
		self.viewModel = viewModel
	}
	
	var body: some View {
		HStack {
			Spacer()
			VStack {
				VStack(alignment: .center) {
					Spacer()
					SettingsTextField(binding: $viewModel.name, descr: "Name:", numbers: false)
					SettingsTextField(binding: $viewModel.rounds, descr: "Rounds:", numbers: true)
					SettingsTextField(binding: $viewModel.roundTime, descr: "Round Time:", numbers: true)
					SettingsTextField(binding: $viewModel.pauseTime, descr: "Pause Time:", numbers: true)
					Spacer()
					HStack {
						Spacer()
						Button(action: saveData) {
							Spacer()
							Text("Save")
								.foregroundColor(.textColor)
							Spacer()
						}
						.padding()
						.background(Color.secondaryAppColor)
						.cornerRadius(15)
						.shadow(radius: 2)
					}
					
						
				}.frame(width: 250)

				Spacer()
			}.padding(.vertical, 20)
			Spacer()
		}
		.navigationTitle("Workout Preparation")
		.navigationBarTitleDisplayMode(.inline)
	}
	
	func saveData() -> Void {
		viewModel.userManager.saveUserData()
	}
}

struct SettingsTextField: View {
	
	@Binding var binding: String
	@State private var editing = false
	let descr: String
	let width : CGFloat = 150
	let numbers: Bool
	var body: some View {
		Group {
			Text(descr)
			if numbers {
			TextField(descr, text: $binding, onEditingChanged: { edit in
				self.editing = edit
			})
				.keyboardType(.numberPad)
				.padding()
				.frame(width: width)
				.overlay(
					RoundedRectangle(cornerRadius: 15)
						.stroke(editing ? Color.secondaryAppColor : Color.black, lineWidth: editing ? 2 : 1)
						.shadow(color: editing ? Color.secondaryAppColor : Color.black ,radius: 2)
				)
				.onReceive(Just(binding)) { newValue in
					let filtered = newValue.filter { "0123456789".contains($0) }
					if filtered != newValue {
						self.binding = filtered
					}
				}
			} else {
				TextField(descr, text: $binding, onEditingChanged: { edit in
					self.editing = edit
				})
					.keyboardType(.numberPad)
					.padding()
					.frame(width: width)
					.overlay(
						RoundedRectangle(cornerRadius: 15)
							.stroke(editing ? Color.secondaryAppColor : Color.black, lineWidth: editing ? 2 : 1)
							.shadow(color: editing ? Color.secondaryAppColor : Color.black ,radius: 2)
					)
			}
		}
	}
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
		SettingsView(viewModel: SettingsViewModel(userManager: UserManager()))
    }
}
