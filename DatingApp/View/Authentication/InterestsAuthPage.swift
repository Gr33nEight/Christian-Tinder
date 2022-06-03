//
//  InterestsAuthPage.swift
//  DatingApp
//
//  Created by Natanael Jop on 14/04/2022.
//

import SwiftUI



struct InterestsAuthPage: View {
    @State var interests = [
        Interest(name: "Music Enthusiast", image: "hifispeaker.fill"),
        Interest(name: "movies", image: "film.fill"),
        Interest(name: "Book Nerd", image: "book.fill"),
        Interest(name: "cooking", image: "cup.and.saucer.fill"),
        Interest(name: "Video Games", image: "gamecontroller.fill"),
        Interest(name: "Traveling", image: "map.fill"),
        Interest(name: "Boating", image: "ferry.fill"),
        Interest(name: "Gambling", image: "banknote.fill"),
        Interest(name: "Technology", image: "laptopcomputer.and.iphone"),
        Interest(name: "Shopping", image: "cart.fill"),
        Interest(name: "Videography", image: "video.fill"),
        Interest(name: "Art", image: "paintpalette.fill"),
        Interest(name: "Design", image: "pencil.tip"),
        Interest(name: "Photography", image: "camera.fill"),
        Interest(name: "Sports", image: "sportscourt.fill")
    ]
    var body: some View {
        VStack{
            topPart()
            ScrollView {
                WrappableHstackForInterests(interests: $interests)
                    .padding()
                    .padding(.top)
            }
            Spacer()
        }.background(Color.customWhite.ignoresSafeArea())
        
    }
    fileprivate func topPart() -> some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(spacing: 15){
                Image(systemName: "hand.thumbsup")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.darkPink)
                    .padding()
                    .background(Circle().fill(Color.lightPink))
                Text("Interests")
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                    .foregroundColor(.customBlue)
                Spacer()
            }
            Text("Select a few of your interests to match with users who have similar things in common.")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.customSecondaryColor)
                .multilineTextAlignment(.leading)
                .padding(.top, 20)
        }.padding([.top, .horizontal], 30)
    }
}

struct InterestsAuthPage_Previews: PreviewProvider {
    static var previews: some View {
        InterestsAuthPage()
            .environmentObject(AuthViewModel())
    }
}
