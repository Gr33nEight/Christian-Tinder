//
//  WalkthroughMainView.swift
//  DatingApp
//
//  Created by Natanael Jop on 14/04/2022.
//

import SwiftUI

struct WalkthroughItem: Hashable {
    var index: Int
    var image: String
    var title: String
    var headline: String
}

struct WalkthroughMainView: View {
    @EnvironmentObject var viewDelegator: AuthViewDelegator
    let cellSize = screenW-120
    @State var walthroughArray = [
        WalkthroughItem(index: 0, image: "chart.pie.fill", title: "Match Algorithm", headline: "Users going through a vetting process to ensure you never match with bots."),
        WalkthroughItem(index: 1, image: "heart.fill", title: "Quality Matches", headline: "We match you with people that have a large array of similar interests."),
        WalkthroughItem(index: 2, image: "crown.fill", title: "Premium", headline: "Sign up today and enjoy the first month of premium benefits on us.")
    ]
    @State var currentIndex = 0
    var body: some View {
        ZStack {
            LinearGradient(colors: [
                .accentColor,
                .lightPink,
            ], startPoint: .bottom, endPoint: .top)
            .ignoresSafeArea()
            VStack(spacing: 20){
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white.opacity(0.4))
                        .frame(width: cellSize-60, height: cellSize-60)
                        .offset(y: 65)
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white.opacity(0.7))
                        .frame(width: cellSize-30, height: cellSize-30)
                        .offset(y: 35)
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                        .frame(width: cellSize, height: cellSize)
                    Image(systemName: walthroughArray[currentIndex].image)
                        .foregroundColor(.accentColor)
                        .font(.system(size: 100, weight: .bold, design: .rounded))
                }
                Text(walthroughArray[currentIndex].title)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.customWhite)
                    .padding()
                    .padding(.top, 50)
                Text(walthroughArray[currentIndex].headline)
                    .font(.system(size: 18, design: .rounded))
                    .lineSpacing(10)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.customWhite)
                    .padding(.horizontal)
                HStack(alignment: .center, spacing: 20) {
                    ForEach(0...2, id:\.self) { idx in
                        Circle()
                            .fill(currentIndex == idx ? .white : Color.customWhite.opacity(0.5))
                            .frame(width: 10, height: 10)
                    }
                }.padding()
                Spacer()
                VStack{
                    if currentIndex == 2 {
                        Button {
                            viewDelegator.showCreateAccount = true
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                                    .frame(height: 70)
                                Text("Create Account")
                                    .font(.system(size: 25, weight: .bold, design: .rounded))
                                    .foregroundColor(.accentColor)
                            }.padding(.horizontal, 20)
                        }

                    }else {
                        Button {
                            currentIndex += 1
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.white)
                                    .frame(height: 70)
                                Text("Continue")
                                    .font(.system(size: 25, weight: .bold, design: .rounded))
                                    .foregroundColor(.accentColor)
                            }.padding(.horizontal, 20)
                        }

                    }
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.customWhite)
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                        Button(action: {}, label: {
                            Text("Sign In")
                        }).foregroundColor(.white)
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                    }.padding()
                        .padding(.bottom, 10)
                }
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct WalkthroughMainView_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughMainView()
    }
}
