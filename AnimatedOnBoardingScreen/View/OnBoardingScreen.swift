//
//  OnBoardingScreen.swift
//  AnimatedOnBoardingScreen
//
//  Created by Shorasul Sh on 20/12/22.
//

import SwiftUI
import Lottie

struct OnBoardingScreen: View {
    @State var onboardingItems: [OnboardingItem] = [
        .init(title: "My test lorem",
                subTitle: "There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain..",
                lottiView: .init(name: "28595-website-building-lottie-animation", bundle: .main)),
        .init(title: "Lorem Ipsum",
                subTitle: "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.",
                lottiView: .init(name: "51083-website-interface", bundle: .main)),
        .init(title: "HODOR IPSUM",
                subTitle: "If you haven't seen Game of Thrones, go watch it right now. If you have then you'll totally get why this Hodor themed lorem ipsum generator is just brilliant.",
                lottiView: .init(name: "57081-graphics-design-lottie-animation", bundle: .main)),
    ]
    var body: some View {
        GeometryReader {
            let size = $0.size

            HStack(spacing: 0) {
                ForEach(onboardingItems) { item in
                    VStack {
                        VStack {
                            Text(item.title)
                                .font(.title.bold())
                        }
                    }
                            .padding(15)
                            .frame(width: size.width, height: size.height)
                }
            }
                    .frame(width: size.width * CGFloat(onboardingItems.count), alignment: .leading)

        }
    }
}

struct OnBoardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingScreen()
    }
}
