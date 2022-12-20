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
        .init(title: "Lorem ipsum dolor sit amet",
              subTitle: "Est dolor quasi est magnam deleniti aut obcaecati dolor. Vel impedit omnis non nostrum quia est omnis deserunt in odio voluptas. Et esse nihil aut provident nesciunt ut cupiditate laudantium et minus neque.",
              lottiView: .init(name: "sad-walking", bundle: .main)),
        .init(title: "Lorem ipsum dolor sit amet",
              subTitle: "Est dolor quasi est magnam deleniti aut obcaecati dolor. Vel impedit omnis non nostrum quia est omnis deserunt in odio voluptas. Et esse nihil aut provident nesciunt ut cupiditate laudantium et minus neque.",
              lottiView: .init(name: "we-are-sorry", bundle: .main)),
        .init(title: "Lorem ipsum dolor sit amet",
              subTitle: "Est dolor quasi est magnam deleniti aut obcaecati dolor. Vel impedit omnis non nostrum quia est omnis deserunt in odio voluptas. Et esse nihil aut provident nesciunt ut cupiditate laudantium et minus neque.",
              lottiView: .init(name: "happy-baby", bundle: .main))
    ]
    
    @State var currentIndex: Int = 0
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            HStack(spacing: 0) {
                ForEach($onboardingItems) { $item in
                    let isLastSlide = currentIndex == onboardingItems.count - 1
                    VStack {
                        //MARK: Top nav bar
                        HStack{
                            Button("Back"){
                                if currentIndex > 0 {
                                    currentIndex -=  1
                                    playAnimation()
                                }
                                
                            }
                            .opacity(currentIndex > 0 ? 1 : 0)
                            Spacer(minLength: 0)
                        }
                        .tint(Color.secondary)
                        .fontWeight(.semibold)
                        
                        //MARK: Movable Slide
                        VStack(spacing: 15) {
                            let offset = -CGFloat(currentIndex) * size.width
                            
                            //MARK: Resizable Lottie view
                            ResizableLottiView(onboardingItem: $item)
                                .frame(height: size.width)
                                .onAppear{
                                    //MARK: Initially playing the first lottie
                                    if(currentIndex == indexOf(item)){
                                        item.lottiView.play(toProgress: 0.9)
                                    }
                                }
                                .offset(x: offset)
                                .animation(.easeOut(duration: 0.5), value: currentIndex)
                            
                            Text(item.title)
                                .font(.title.bold())
                                .offset(x: offset)
                                .animation(.easeOut(duration: 0.5).delay(0.1), value: currentIndex)
                            
                            Text(item.subTitle)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .offset(x: offset)
                                .animation(.easeOut(duration: 0.5).delay(0.2), value: currentIndex)
                            
                        }
                        
                        Spacer(minLength: 0)
                        
                        //MARK: Next / Login Button
                        VStack(spacing: 15){
                            Text(isLastSlide ? "Happy end" : "Next")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical,12)
                                .frame(maxWidth: .infinity)
                                .background{
                                    Capsule()
                                        .fill(Color(uiColor: .black))
                                }
                                .padding(.horizontal, isLastSlide ? 30 : 100)
                                .onTapGesture{
                                    //MARK: update to the next index
                                    if currentIndex < onboardingItems.count - 1 {
                                        onboardingItems[currentIndex].lottiView.pause()
                                        currentIndex += 1
                                        playAnimation()
                                    }
                                    
                                }
                            
                            HStack{
                                Text("Term of Momoxa")
                                Text("Privacy of Nurangiz")
                                
                            }
                            .font(.caption2)
                            .underline(true, color: .primary)
                            .offset(y: 5)
                            
                        }
                        
                    }
                    .animation(.easeOut, value: isLastSlide)
                    .padding(14)
                    .frame(width: size.width, height: size.height)
                }
            }
            .frame(width: size.width * CGFloat(onboardingItems.count), alignment: .leading)
            
        }
    }
    
    func playAnimation(){
        onboardingItems[currentIndex].lottiView.currentProgress = 0
        onboardingItems[currentIndex].lottiView.play(fromProgress: 0,  toProgress: 1,
                                                     loopMode: LottieLoopMode.loop)
    }
    
    //MARK: retrieving index of items
    func indexOf(_ item: OnboardingItem) -> Int{
        if let index = onboardingItems.firstIndex(of: item){
            return index
        }
        return 0
    }
}

struct OnBoardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingScreen()
    }
}

struct ResizableLottiView: UIViewRepresentable{
    @Binding var onboardingItem: OnboardingItem
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func setupLottieView(_ to: UIView){
        let lottieView =  onboardingItem.lottiView
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: Applying Constrains
        let constrains = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor)
        ]
        to.addSubview(lottieView)
        to.addConstraints(constrains)
        
    }
}
