//
//  MediaAuthPage.swift
//  DatingApp
//
//  Created by Natanael Jop on 14/04/2022.
//

import SwiftUI

struct MediaAuthPage: View {
    @EnvironmentObject var authVM: AuthViewModel
    let cellHeight = screenH/3.5
    var body: some View {
        VStack{
            topPart()
            imageCell()
            Spacer()
        }.background(Color.customWhite.ignoresSafeArea())
    }
    fileprivate func topPart() -> some View {
        VStack(alignment: .leading){
            HStack(spacing: 15){
                Image(systemName: "camera")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.darkPink)
                    .padding()
                    .background(Circle().fill(Color.lightPink))
                Text("Media")
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                    .foregroundColor(.customBlue)
                Spacer()
            }
            Text("Add your best photots to get a higher amount of daily matches")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.customSecondaryColor)
                .multilineTextAlignment(.leading)
                .padding(.vertical, 10)
        }.padding([.top, .horizontal], 30)
    }
    fileprivate func imageCell() -> some View {
        GeometryReader { geo in
            LazyVGrid(columns: [GridItem(.adaptive(minimum: .infinity, maximum: .infinity)), GridItem(.adaptive(minimum: .infinity, maximum: .infinity))], spacing: 5) {
                ForEach(1..<5) { _ in
                    Button {
                        authVM.accountInformation.mediaInformation.isDone = true
                    } label: {
                        VStack{
                            Spacer()
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.lightPink)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .strokeBorder(Color.accentColor ,style: StrokeStyle(lineWidth: 3, dash: [8]))
                                    )
                                Image(systemName: "plus")
                                    .foregroundColor(.customWhite)
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .padding(22)
                                    .background(Circle().fill(Color.darkPink))
                                    .shadow(color: Color.accentColor, radius: 20)
                            }.padding(.horizontal, 5)

                            Spacer()
                        }
                    }.frame(height: geo.size.height/2.2)
                }
            }.padding(20)
        }
    }
}

struct MediaAuthPage_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountMainView()
            .environmentObject(AuthViewModel())
    }
}
