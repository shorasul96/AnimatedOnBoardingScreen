//
//  OnBoardingItem.swift
//  AnimatedOnBoardingScreen
//
//  Created by Shorasul Sh on 20/12/22.
//

import SwiftUI
import Lottie

struct OnboardingItem: Identifiable,Equatable {
    var id: UUID = .init()
    var title: String
    var subTitle: String
    var lottiView: LottieAnimationView = .init()
}
