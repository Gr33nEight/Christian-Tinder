//
//  HomeViewCardDelegator.swift
//  ChristianTinder
//
//  Created by Natanael Jop on 03/04/2022.
//

import SwiftUI

extension HomeMainView {
    func cardDelegator() -> some View {
        ZStack {
            ForEach(filteredProfileCards.indices.reversed(), id: \.self) { idx in
                if homeVM.centeredIndex > idx {
                    
                }else{
                    VStack{
                        VStack {
                            if (idx - homeVM.centeredIndex) <= 1  {
                                profileCardView(idx: idx, card: filteredProfileCards[idx]).zIndex(2)
                                    .onTapGesture {
                                        showProfile()
                                        homeVM.currentProfile = filteredProfileCards[idx]
                                    }
                                    .onChange(of: decided){ new in
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            if decided { withAnimation { homeVM.centeredIndex = idx}}
                                        }
                                    }

                                Spacer()
                                decideButtons(idx: idx)
                                    .padding(10)
                                    .padding(.bottom, 5)
                                Spacer()
                            }else{Color.white.frame(maxHeight: smallIPhones.contains(UIDevice.modelName) ? screenH/2.5 : .infinity)}
                        }.opacity(idx - homeVM.centeredIndex <= 1 ? 1 : 0)
                        .background(Color.white)
                            .opacity((1 - 0.5 * (Double(idx - homeVM.centeredIndex - 1))))
                            .cornerRadius(20)
                            .offset(x: filteredProfileCards[idx].offset)
                            .scaleEffect(CGSize(width: 1 + (0.15 * Double(homeVM.centeredIndex - idx)), height: 1 + (0.15 * Double(homeVM.centeredIndex - idx))))
                            .shadow(color: .black.opacity(0.1), radius: 20, y: 2)
                            .padding(.vertical, 36)
                            .frame(width: screenW - 40)
                    }
                    .zIndex(idx >= homeVM.centeredIndex ? 1 : 0)
                    .rotationEffect(.degrees((filteredProfileCards[idx].offset)*0.05))
                    .gesture(
                        DragGesture()
                            .onChanged({ drag in
                                if idx == homeVM.centeredIndex {
                                    onChanged(value: drag, index: idx)
                                }
                            })
                            .onEnded({ drag in
                                if idx == homeVM.centeredIndex {
                                    onEnded(value: drag, index: idx)
                                }
                            })
                        )
                    .transition(isLiked ? .move(edge: .trailing) : .move(edge: .leading))
                    .offset(y: 0 - ((smallIPhones.contains(UIDevice.modelName) ? 45.0 : 65.0) * Double(homeVM.centeredIndex - idx)))
                }
            }
        }

    }
    fileprivate func onChanged(value: DragGesture.Value, index: Int) {
        disableButtons = true
        withAnimation {
            filteredProfileCards[index].offset = value.translation.width * 1.5
        }
        
        if filteredProfileCards[index].offset < -screenW / 2.5 {
            withAnimation {
                isLiked = false
            }
        }else if filteredProfileCards[index].offset > screenW / 2.5 {
            withAnimation {
                isLiked = true
            }
        }
    }
    fileprivate func onEnded(value: DragGesture.Value, index: Int) {
        disableButtons = false
        if filteredProfileCards[index].offset < -screenW / 2.5 {
            withAnimation {
                homeVM.centeredIndex = index + 1
            }
        }else if filteredProfileCards[index].offset > screenW / 2.5 {
            withAnimation {
                homeVM.centeredIndex = index + 1
            }
        }else{
            withAnimation {
                filteredProfileCards[index].offset = 0
            }
        }
    }
    fileprivate func getWidth(idx: Int) -> Double {
        return 20.0 * (Double(homeVM.centeredIndex - idx))
    }
    fileprivate func profileCardView(idx: Int, card: ProfileCard) -> some View {
        ZStack{
            compressImage(imageName: filteredProfileCards[idx].profile.image)
                .resizable()
                .centerCropped()
                .matchedGeometryEffect(id: filteredProfileCards[idx].id, in: showProfileViewAnim, properties: .frame, isSource: true)
            cardOverlay(card: card)
        }.frame(maxHeight: smallIPhones.contains(UIDevice.modelName) ? screenH/2.5 : .infinity)
        .aspectRatio(0.7, contentMode: .fill)
            .cornerRadius(25)
            .clipped()
            .padding(15)
    }
    fileprivate func decideButtons(idx: Int) -> some View {
        HStack{
            Spacer()
            Button {
                isLiked = false
                withAnimation {
                    homeVM.centeredIndex = idx + 1
                }
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.customPink)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding()
                    .background(
                        Circle()
                            .fill(Color.lightPink)
                            .frame(width: 50, height: 50)
                    )
            }.opacity((idx - homeVM.centeredIndex) <= 0 ? 1 : 0)
            Spacer()
            Button {
                isLiked = true
                withAnimation {
                    homeVM.centeredIndex = idx + 1
                }
            } label: {
                Image("heart")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
                    .padding()
                    .background(
                        Circle()
                            .fill(Color.customPink)
                            .frame(width: 50, height: 50)
                    )
            }.opacity((idx - homeVM.centeredIndex) <= 0 ? 1 : 0)
                
            Spacer()
        }.disabled(disableButtons)
    }
    fileprivate func cardOverlay(card: ProfileCard) -> some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.9), Color.black.opacity(0.2), Color.black.opacity(0.1)]), startPoint: .bottom, endPoint: .top)
            VStack{
                Spacer()
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        HStack(spacing: 0){
                            Text("\(card.profile.name)")
                            Text(", \(card.profile.age)")
                        }.foregroundColor(.white)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                        HStack(spacing: 0){
                            ForEach(card.profile.perks, id: \.self){ perk in
                                Text(perk)
                                if perk != card.profile.perks.last! {
                                    Text(", ")
                                }
                            }
                        }.foregroundColor(.white)
                        
                    }
                    Spacer()
                }.padding(25)
            }
            VStack{
                HStack {
                    Spacer()
                    Text("\(card.profile.localization.formatted()) Km")
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 25).fill(Color.black.opacity(0.7)))
                }.padding()
                Spacer()
            }
        }
    }
}


struct HomeMainView_Previews3: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

