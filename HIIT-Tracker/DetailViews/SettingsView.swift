//
//  SettingsView.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 12.11.21.
//
import Combine
import SwiftUI

struct SettingsView: View {
	@EnvironmentObject var userManager: UserManager
	
	@State private var name = ""
	@State private var rounds = ""
	@State private var roundTime = ""
	@State private var pauseTime = ""
	
	var body: some View {
		HStack {
			Spacer()
			VStack {
				VStack(alignment: .center) {
					Spacer()
					SettingsTextField(binding: $name, descr: "Name:", numbers: false)
					SettingsTextField(binding: $rounds, descr: "Rounds:", numbers: true)
					SettingsTextField(binding: $roundTime, descr: "Round Time:", numbers: true)
					SettingsTextField(binding: $pauseTime, descr: "Pause Time:", numbers: true)
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
		.onAppear(perform: {
			name = userManager.userData!.name
			rounds = userManager.userData!.standardRounds
			roundTime = userManager.userData!.standardRoundTime
			pauseTime = userManager.userData!.standardPauseTime
		})
		.background(Color.mainAppColor)
	}
	
	func saveData() -> Void {
		userManager.saveUserData(name: name, standardRounds: rounds, standardRoundTime: roundTime, standardPauseTime: pauseTime)
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
				.foregroundColor(.textColor)
			if numbers {
			TextField("", text: $binding, onEditingChanged: { edit in
				self.editing = edit
			})
				.keyboardType(.numberPad)
				.padding()
				.frame(width: width)
				.background(
				RoundedRectangle(cornerRadius: 15)
					.fill(Color.white)
				)
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
				TextField("", text: $binding, onEditingChanged: { edit in
					self.editing = edit
				})
					.keyboardType(.numberPad)
					.padding()
					.frame(width: width)
					.background(
					RoundedRectangle(cornerRadius: 15)
						.fill(Color.white)
					)
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
		SettingsView()
    }
}
