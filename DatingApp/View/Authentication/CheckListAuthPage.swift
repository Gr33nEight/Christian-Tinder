//
//  CheckListAuthPage.swift
//  DatingApp
//
//  Created by Natanael Jop on 14/04/2022.
//

import SwiftUI

struct CheckListModel: Identifiable {
    var id = UUID().uuidString
    var name: String
    var sub: String
    var view: AnyView
    var isDone: Bool = false
}

struct CheckListAuthPage: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State var checkList: [CheckListModel] = [
        CheckListModel(name: "Name", sub: "Enter your full name.", view: AnyView(CreateAuthPage())),
        CheckListModel(name: "Media", sub: "Upload your best photos.", view: AnyView(MediaAuthPage())),
        CheckListModel(name: "Ideal Match", sub: "What are you looking for?", view: AnyView(IdealMatchAuthPage())),
        CheckListModel(name: "Interests", sub: "Find users with similar interests.", view: AnyView(InterestsAuthPage())),
    ]
    
    var mainInformation: MainInformation {
        return authVM.accountInformation.mainInformation
    }
    var mediaInformation: MediaInformation {
        return authVM.accountInformation.mediaInformation
    }
    var idealMatchInformation: IdealMatchInformation {
        return authVM.accountInformation.idealMatchInformation
    }
    var interestsInformation: InterestsInformation {
        return authVM.accountInformation.interestsInformation
    }
    
    var body: some View {
        VStack{
            topPart()
            centerPart()
            Spacer()
        }.background(Color.customWhite.ignoresSafeArea())
    }
    fileprivate func topPart() -> some View {
        VStack(alignment: .leading){
            HStack(spacing: 15){
                Image(systemName: "checklist")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.darkPink)
                    .padding()
                    .background(Circle().fill(Color.lightPink))
                Text("Checklist")
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                    .foregroundColor(.customBlue)
                Spacer()
            }
            Text("Users who fill out their profile get up to 4x the amount of matches")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.customSecondaryColor)
                .multilineTextAlignment(.leading)
                .padding(.vertical, 10)
        }.padding([.top, .horizontal], 30)
    }
    fileprivate func centerPart() -> some View {
        VStack(spacing: 0){
            cell(headline: mainInformation.headline, subheadline: mainInformation.subheadline, isDone: mainInformation.isDone, viewIndex: mainInformation.viewIndex, secondSubHeadline: mainInformation.fullname)
            cell(headline: mediaInformation.headline, subheadline: mediaInformation.subheadline, isDone: mediaInformation.isDone, viewIndex: mediaInformation.viewIndex, secondSubHeadline: mediaInformation.subheadline)
            cell(headline: idealMatchInformation.headline, subheadline: idealMatchInformation.subheadline, isDone: idealMatchInformation.isDone, viewIndex: idealMatchInformation.viewIndex, secondSubHeadline: idealMatchInformation.typeOfMatch)
            cell(headline: interestsInformation.headline, subheadline: interestsInformation.subheadline, isDone: interestsInformation.isDone, viewIndex: interestsInformation.viewIndex, secondSubHeadline: interestsInformation.interests.first?.name ?? "")
        }
    }
    fileprivate func cell(headline: String, subheadline: String, isDone: Bool, viewIndex: Int, secondSubHeadline: String) -> some View {
        Button {
            authVM.currentIndex = viewIndex
        } label: {
            HStack{
                Image(systemName: "checkmark")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(isDone ? .white : .customBlue.opacity(0.5))
                    .padding(20)
                    .background(Circle().fill(isDone ? Color.accentColor : Color.customSecondaryColor))
                    .shadow(color: .accentColor.opacity(isDone ? 0.8 : 0), radius: 15, y: 8)
                    .padding(20)
                VStack(alignment: .leading, spacing: 5){
                    Text(headline)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.customBlue)
                    Text(isDone ? secondSubHeadline : subheadline)
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.customSecondaryColor)
                }
                
                Spacer()
            }.padding(.vertical, 7)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                .shadow(color: .black.opacity(0.1), radius: 20)
                .padding()
        }

    }
}

struct CheckListAuthPage_Previews: PreviewProvider {
    static var previews: some View {
        CheckListAuthPage()
            .environmentObject(AuthViewModel())
    }
}
