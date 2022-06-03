//
//  LikesMainView.swift
//  ChristianTinder
//
//  Created by Natanael Jop on 02/04/2022.
//

import SwiftUI

struct LikesMainView: View {
    @State var canDrag = true
    //    @State var isLiked = false
    @EnvironmentObject var likesVM: LikesViewModel
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(showsIndicators: false) {
                    if !likesVM.matchCards.isEmpty {
                        HStack{
                            Text("Matches")
                                .foregroundColor(.accentColor)
                                .font(.system(size: 35, weight: .bold, design: .rounded))
                            Spacer()
                        }.padding(20)
                        
                        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 0) {
                            ForEach(likesVM.matchCards.indices) { idx in
                                if likesVM.matchCards[idx].show {
                                    profileMatchCard(idx: idx)
                                }
                            }
                        }.padding()
                    }
                    
                    if !likesVM.likeCards.isEmpty {
                        HStack{
                            Text("Likes")
                                .foregroundColor(.accentColor)
                                .font(.system(size: 35, weight: .bold, design: .rounded))
                            Spacer()
                        }.padding(20)
                        
                        
                        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 0) {
                            ForEach(likesVM.likeCards.indices) { idx in
                                if likesVM.likeCards[idx].show {
                                    profileLikeCard(idx: idx)
                                }
                            }
                        }.padding()
                    }
                    
                }
            }.background(Color.customWhite)
            .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
    fileprivate func profileLikeCard(idx: Int) -> some View {
        Image(likesVM.likeCards[idx].profile.profile.image)
            .resizable()
            .centerCropped()
            .frame(height: 220)
            .scaledToFill()
            .cornerRadius(25)
            .overlay(
                ZStack {
                    BlurView(style: .light).frame(height: 50)
                    HStack(spacing: 0) {
                        Text(likesVM.likeCards[idx].profile.profile.name) +
                        Text(", \(likesVM.likeCards[idx].profile.profile.age)")
                        Spacer()
                    }.padding(.leading)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.customBlue)
                }
                , alignment: .bottom
            )
            .cornerRadius(25)
            .padding(8)
            .offset(x: likesVM.likeCards[idx].offset)
            .rotationEffect(.degrees((likesVM.likeCards[idx].offset)*0.05))
            .gesture(
                DragGesture()
                    .onChanged({ drag in
                        onChangedLikes(value: drag, idx: idx)
                    })
                    .onEnded({ drag in
                        onEndedLikes(value: drag, idx: idx)
                    })
            )
            .zIndex(likesVM.likeCards[idx].dragDisabled ? 0 : 1)
            .transition(.slide)
        
    }
    fileprivate func profileMatchCard(idx: Int) -> some View {
        Image(likesVM.matchCards[idx].profile.profile.image)
            .resizable()
            .centerCropped()
            .frame(height: 220)
            .scaledToFill()
            .cornerRadius(25)
            .overlay(
                ZStack {
                    BlurView(style: .light).frame(height: 50)
                    HStack(spacing: 0) {
                        Text(likesVM.matchCards[idx].profile.profile.name) +
                        Text(", \(likesVM.matchCards[idx].profile.profile.age)")
                        Spacer()
                    }.padding(.leading)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(.customBlue)
                }
                , alignment: .bottom
            )
            .cornerRadius(25)
            .padding(8)
            .offset(x: likesVM.matchCards[idx].offset)
            .rotationEffect(.degrees((likesVM.matchCards[idx].offset)*0.05))
            .gesture(
                DragGesture()
                    .onChanged({ drag in
                        onChangedMatches(value: drag, idx: idx)
                    })
                    .onEnded({ drag in
                        onEndedMatches(value: drag, idx: idx)
                    })
            )
            .zIndex(likesVM.matchCards[idx].dragDisabled ? 0 : 1)
            .transition(.slide)
        
    }
    func onChangedLikes(value: DragGesture.Value, idx: Int) {
        
        for i in 0...(likesVM.likeCards.count - 1) {
            if i != idx {
                likesVM.likeCards[i].dragDisabled = true
            }
        }
        
        withAnimation {
            likesVM.likeCards[idx].offset = value.translation.width
        }
        
        if likesVM.likeCards[idx].offset < -90 {
            withAnimation {
                //                isLiked = false
            }
        }else if likesVM.likeCards[idx].offset > 90 {
            withAnimation {
                //                isLiked = true
            }
        }
    }
    func onEndedLikes(value: DragGesture.Value, idx: Int) {
        if likesVM.likeCards[idx].offset < -90 {
            withAnimation {
                likesVM.likeCards[idx].show = false
                //                isLiked = false
            }
        }else if likesVM.likeCards[idx].offset > 90 {
            withAnimation {
                likesVM.likeCards[idx].show = false
                //                isLiked = true
            }
        }else{
            withAnimation {
                likesVM.likeCards[idx].offset = 0
            }
        }
        for i in 0...(likesVM.likeCards.count - 1) {
            likesVM.likeCards[i].dragDisabled = false
        }
    }
    func onChangedMatches(value: DragGesture.Value, idx: Int) {
        
        for i in 0...(likesVM.matchCards.count - 1) {
            if i != idx {
                likesVM.matchCards[i].dragDisabled = true
            }
        }
        
        withAnimation {
            likesVM.matchCards[idx].offset = value.translation.width
        }
        
        if likesVM.matchCards[idx].offset < -90 {
            withAnimation {
                //                isLiked = false
            }
        }else if likesVM.matchCards[idx].offset > 90 {
            withAnimation {
                //                isLiked = true
            }
        }
    }
    func onEndedMatches(value: DragGesture.Value, idx: Int) {
        if likesVM.matchCards[idx].offset < -90 {
            withAnimation {
                likesVM.matchCards[idx].show = false
                //                isLiked = false
            }
        }else if likesVM.matchCards[idx].offset > 90 {
            withAnimation {
                likesVM.matchCards[idx].show = false
                //                isLiked = true
            }
        }else{
            withAnimation {
                likesVM.matchCards[idx].offset = 0
            }
        }
        for i in 0...(likesVM.matchCards.count - 1) {
            likesVM.matchCards[i].dragDisabled = false
        }
    }
}


struct LikesMainView_Previews: PreviewProvider {
    static var previews: some View {
        LikesMainView()
            .environmentObject(LikesViewModel(homeVM: HomeViewModel()))
    }
}
