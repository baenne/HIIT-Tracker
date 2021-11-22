//
//  LottieView.swift
//  HIIT-Tracker
//
//  Created by Benedikt Jensch on 22.11.21.
//

import SwiftUI
import Lottie

struct LottieAnimationView: UIViewRepresentable {
	public static let animations = ["frog-press","inchworm","jumping-jack","lunge","punches","reverse-crunch", "shoulder-stretch", "squad-kick"]
	@Binding var animationInProgress: Bool
	let name: String
	func makeUIView(context: Context) -> some AnimationView {
		let lottieAnimationView = AnimationView(name: name)
		lottieAnimationView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
		lottieAnimationView.contentMode = .scaleAspectFit
		lottieAnimationView.loopMode = .loop
		lottieAnimationView.animationSpeed = 1.0
		lottieAnimationView.play()
		return lottieAnimationView
	}
	
	func updateUIView(_ uiView: UIViewType, context: Context) {
	}
}

struct LottieAnimationView_Previews: PreviewProvider {
	static var binding = Binding(get: { return true }, set: { _ in})
    static var previews: some View {
		LottieAnimationView(animationInProgress: LottieAnimationView_Previews.binding, name: LottieAnimationView.animations.randomElement() ?? "lunge")
    }
}
