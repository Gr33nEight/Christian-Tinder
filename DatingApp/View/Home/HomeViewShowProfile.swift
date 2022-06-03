//
//  HomeViewShowProfile.swift
//  ChristianTinder
//
//  Created by Natanael Jop on 03/04/2022.
//

import SwiftUI

extension HomeMainView {
    func showProfile() {
        withAnimation {
//            navBarVM.show = false
            showProfileView = true
        }
    }
    func profileView() -> some View {
        ZStack{
            Color.customWhite
            VStack{
                    ZStack(alignment: .top) {
                        TabView(selection: $currentIndex) {
                            ForEach(homeVM.currentProfile.profile.additionaImages.indices, id: \.self) { idx in
                                compressImage(imageName: homeVM.currentProfile.profile.additionaImages[idx])
                                    .resizable()
                                    .centerCropped()
                                    .tag(idx + 1)
                            }.ignoresSafeArea()
                        }.matchedGeometryEffect(id: filteredProfileCards[homeVM.centeredIndex].id, in: showProfileViewAnim, properties: .frame, isSource: true)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                            .edgesIgnoringSafeArea(.all)
                    }.frame(height: screenH/1.8)
                    .cornerRadius(30)
                    .shadow(color: .black.opacity(0.4), radius: 13, x: 0, y: 10)
                    .frame(height: screenH/1.8)
                    .overlay(
                        profileButtons()
                    )
                centerPart()
                
                Spacer()
            }
        }.ignoresSafeArea()
            .onAppear {
                homeVM.currentProfile.profile.additionaImages.insert(homeVM.currentProfile.profile.image, at: 0)
                decided = false
                withAnimation {
                    navBarVM.show = false
                }
            }
    }
    
    fileprivate func profileButtons() -> some View  {
        VStack{
            HStack{
                Button(action: {
                    withAnimation {
                        showProfileView = false
                        navBarVM.show = true
                    }
                    currentIndex = 1
                }) {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .background(Color.customWhite.frame(width: 50, height: 40).cornerRadius(20))
                        .padding(25)
                }
                Spacer()
                Text("\(currentIndex)/\(homeVM.currentProfile.profile.additionaImages.count)")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .background(Color.customWhite.frame(width: 50, height: 40).cornerRadius(20))
                    .padding(25)
            }.padding()
            Spacer()
            HStack(spacing: 30){
                Spacer()
                Button(action: {
                    
                    withAnimation {
                        showProfileView = false
                        navBarVM.show = true
                    }
                        isLiked = false
                        decided = true
                        currentIndex = 1
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding()
                        .background(
                            Circle()
                                .fill(Color.lightPink)
                                .frame(width: 60, height: 60)
                        )
                }.shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
                Button(action: {
                    withAnimation {
                        showProfileView = false
                        navBarVM.show = true
                    }
                    isLiked = true
                    decided = true
                    currentIndex = 1
                }) {
                    Image("heart")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(
                            Circle()
                                .fill(Color.accentColor)
                                .frame(width: 100, height: 100)
                        )
                }.shadow(color: .black.opacity(0.12), radius: 20, x: 0, y: 20)
                NavigationLink {
                    ConversationView(conversation: .init(user: homeVM.currentProfile, messages: messagesVM.messages))
                } label: {
                    Image(systemName: "envelope")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding()
                        .background(
                            Circle()
                                .fill(Color.lightPink)
                                .frame(width: 60, height: 60)
                        )
                }.shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
                Spacer()
            }.offset(y: 30)
        }
    }
    
    fileprivate func centerPart() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 5){
                HStack(spacing: 0){
                    Text("\(homeVM.currentProfile.profile.name), ")
                        .underline(color: .lightPink)
                    Text("\(homeVM.currentProfile.profile.age)")
                    Spacer()
                    Button(action: {}) {
                        Text("\(homeVM.currentProfile.profile.localization.formatted()) Km")
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundColor(.customSecondaryColor)
                            .padding(10)
                            .background(Color.white.cornerRadius(15))
                    }.shadow(color: .black.opacity(0.1), radius: 7, x: 0, y: 8)
                }
                    .foregroundColor(.darkPink)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                HStack(spacing: 0){
                    ForEach(homeVM.currentProfile.profile.perks, id: \.self){ perk in
                        Text(perk)
                        if perk != homeVM.currentProfile.profile.perks.last! {
                            Text(", ")
                        }
                    }
                }.font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.customSecondaryColor)
                Text("About")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.top, 20)
                    .foregroundColor(.accentColor)
                Text("\(homeVM.currentProfile.profile.description)").lineLimit(3)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(.customSecondaryColor)
                Text("Interest")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.top, 20)
                    .foregroundColor(.accentColor)
                WrappableHstack(items: homeVM.currentProfile.profile.perks, bgcolor: .lightPink, txtcolor: .darkPink)
                    .padding(.top, 10)
            }
        }.padding(.top, 55)
        .padding(.horizontal, 30)

    }
}

