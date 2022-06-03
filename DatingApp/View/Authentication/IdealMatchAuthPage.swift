//
//  IdealMatchAuthPage.swift
//  DatingApp
//
//  Created by Natanael Jop on 14/04/2022.
//

import SwiftUI

struct IdealMatch: Hashable {
    var name: String
    var image: String
    var isPicked = false
}

struct IdealMatchAuthPage: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State var idealMatches = [
        IdealMatch(name: "Love", image: "heart"),
        IdealMatch(name: "Friends", image: "person.2"),
        IdealMatch(name: "Fling", image: "cup.and.saucer"),
        IdealMatch(name: "Business", image: "suitcase")
    ]
    var body: some View {
        VStack{
            topPart()
            Spacer()
            centerPart()
        }.background(Color.customWhite.ignoresSafeArea())
    }
    fileprivate func topPart() -> some View {
        VStack(alignment: .leading){
            HStack(spacing: 15){
                Image(systemName: "heart")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.darkPink)
                    .padding()
                    .background(Circle().fill(Color.lightPink))
                Text("Ideal Match")
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                    .foregroundColor(.customBlue)
                Spacer()
            }
            Text("What are you hoping to find on the dating app?")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.customSecondaryColor)
                .multilineTextAlignment(.leading)
                .padding(.vertical, 10)
        }.padding([.top, .horizontal], 30)
    }
    fileprivate func centerPart() -> some View {
        GeometryReader { geo in
            VStack{
                Spacer()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: .infinity, maximum: .infinity)), GridItem(.adaptive(minimum: .infinity, maximum: .infinity))], spacing: 10) {
                    ForEach(idealMatches.indices, id:\.self) { idx in
                        Button {withAnimation{ pickOption(idx: idx) }} label: {
                            ZStack {
                                if idealMatches[idx].isPicked { Color.lightPink } else { Color.white }
                                VStack{
                                    Spacer()
                                    Image(systemName: idealMatches[idx].image)
                                        .padding(30)
                                        .foregroundColor(.accentColor)
                                        .font(.system(size: 25, weight: .bold, design: .rounded))
                                        .background(Circle().fill(idealMatches[idx].isPicked ? Color.white : Color.lightPink))
                                    Spacer()
                                    Text(idealMatches[idx].name)
                                        .foregroundColor(.customBlue)
                                        .font(.system(size: 25, weight: .bold, design: .rounded))
                                    Spacer()
                                }
                            }.frame(height: geo.size.height/2.5)
                                .cornerRadius(20)
                        }.shadow(color: .lightPink.opacity(idealMatches[idx].isPicked ? 1 : 0), radius: 20)
                    }
                }.padding(20)
                Spacer()
            }.padding(.bottom, 30)
        }
    }
    func pickOption(idx: Int) {
        authVM.accountInformation.idealMatchInformation.isDone = true
        withAnimation {
            for i in 0...idealMatches.count-1 {
                idealMatches[i].isPicked = false
            }
            idealMatches[idx].isPicked = true
            authVM.accountInformation.idealMatchInformation.typeOfMatch = idealMatches[idx].name
        }
    }
}

struct IdealMatchAuthPage_Previews: PreviewProvider {
    static var previews: some View {
        IdealMatchAuthPage()
    }
}
