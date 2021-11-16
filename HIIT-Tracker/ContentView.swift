//
//  ContentView.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 12.11.21.
//

import CoreData
import SwiftUI

enum ViewState: Int {
	case mainMenu = 0
	case intro = 4
}

struct ContentView: View {
	@Environment(\.managedObjectContext) private var viewContext
	@ObservedObject var userManager: UserManager
	@State private var viewState: ViewState? = .intro
	@EnvironmentObject var navigationHelper: NavigationHelper
	@ViewBuilder
	var body: some View {
		NavigationView {
			VStack(alignment: .center) {
				withAnimation {
					HStack {
						Spacer()

						Text("HIIT-Tracker")
							.font(.title)
							.foregroundColor(.textColor)

						Spacer()
					}
				}
				Spacer()
				Image(systemName: "timer")
					.renderingMode(.template)
					.resizable()
					.foregroundColor(.textColor)
					.scaledToFit()
					.frame(width: 150, height: 150)
				Spacer()
				if viewState == .intro {
					Button(action: {
						withAnimation {
							setViewState(viewState: .mainMenu)
						}
					}) {
						Text("Start")
							.foregroundColor(.textColor)
					}
					.padding()
					.background(Color.secondaryAppColor)
					.cornerRadius(15)
					.shadow(radius: 2)
				} else if viewState == .mainMenu {
					MainMenuView(userManager: userManager)
				}
				Spacer()
			}
			.background(Color.mainAppColor)
		}
	}

	func setViewState(viewState: ViewState) {
		self.viewState = viewState
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(userManager: UserManager()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
	}
}
