//
//  ChatView.swift
//  DatingApp
//
//  Created by Natanael Jop on 05/04/2022.
//

import SwiftUI

struct ConversationView: View {
    @EnvironmentObject var messagesVM: MessagesViewModel
    @Environment(\.presentationMode) var mode
    @State var textInput = ""
    var conversation: ConversationModel
    var body: some View {
        NavigationView {
            VStack(spacing: 0){
                topPart()
                mainScrollView()
                textField()
            }.navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
    
    fileprivate func topPart () -> some View {
        ZStack(alignment: .top){
            HStack(spacing: 20){
                Button {mode.wrappedValue.dismiss()} label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.customBlue)
                }
                compressImage(imageName: conversation.user.profile.image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 3){
                    Text("\(conversation.user.profile.name), ") +
                    Text("\(conversation.user.profile.age)")
                    Text("Online 24 mins ago")
                        .foregroundColor(.customSecondaryColor)
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                }.foregroundColor(.customBlue)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                Spacer()
                Button(action: {}) {
                    Image(systemName: "phone.fill")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(.darkPink)
                }.background(RoundedRectangle(cornerRadius: 10).fill(Color.lightPink).frame(width: 35, height: 35))
                    .padding(.trailing, 5)
                Button(action: {}) {
                    Image(systemName: "video.fill")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(.darkPink)
                }.background(RoundedRectangle(cornerRadius: 10).fill(Color.lightPink).frame(width: 35, height: 35))
                
            }
                .padding(.bottom, 5)
                .padding(.horizontal, 20)
                .background(Color.white
                                .edgesIgnoringSafeArea(.top))
        }
    }
    fileprivate func mainScrollView() -> some View {
        ScrollView(showsIndicators: false) {
            ScrollViewReader { value in
                LazyVStack(spacing: 0){
                    Spacer()
                    ForEach(messagesVM.messages.indices, id: \.self) { idx in
                        cellView(message: messagesVM.messages[idx], show: show(idx: idx))
                    }
                }.padding(.bottom)
                    .onChange(of: messagesVM.messages.count) { _ in
                        value.scrollTo(messagesVM.messages.count - 1)
                    }
            }
            
        }.background(Color.customWhite)
            .ignoresSafeArea()
    }
    func show(idx: Int) -> Bool {
        return (idx+1) < messagesVM.messages.count ? messagesVM.messages[idx].isFromCurrentUser != messagesVM.messages[idx+1].isFromCurrentUser : true
    }
    fileprivate func cellView(message: Message, show: Bool) -> some View {
        ZStack{
            if message.isFromCurrentUser {
                HStack{
                    Spacer()
                    VStack(alignment: .trailing, spacing: 5){
                        Text(message.textMessage)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.customWhite)
                            .padding(15)
                            .background(RoundedRectangle(cornerRadius: 25).fill(Color.accentColor))
                        if show {
                            Text("08.35")
                                .foregroundColor(.customSecondaryColor)
                                .font(.system(size: 11, weight: .semibold, design: .rounded))
                            
                        }
                    }
                }.padding(.horizontal, 30)
                    .padding(.leading, 90)
            } else {
                HStack(alignment: .bottom, spacing: 0){
                    if show {
                        compressImage(imageName: conversation.user.profile.image)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 25, height: 25)
                    }
                    VStack(alignment: .leading, spacing: 5){
                        Text(message.textMessage)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.customBlue)
                            .padding(15)
                            .background(RoundedRectangle(cornerRadius: 25).fill(Color.white))
                        if show {
                            Text("08.35")
                                .foregroundColor(.customSecondaryColor)
                                .font(.system(size: 11, weight: .semibold, design: .rounded))
                                .padding(.leading, 10)
                        }
                    }
                    Spacer()
                }.padding(.leading, show ? 0 : 22)
                .padding(.horizontal, 15)
                    .padding(.trailing, 80)

            }
        }.padding(.bottom, show ? 20 : 5)
    }
    fileprivate func textField() -> some View {
        HStack(spacing: 10){
            ZStack(alignment: .bottom){
                Color.customWhite
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                    if textInput.isEmpty {
                        Text("Wyślij wiadomość...")
                            .padding(.leading, 30)
                    }
                    TextField("", text: $textInput)
                        .padding(.leading, 30)
                        .foregroundColor(.customBlue)
                }.padding(.vertical, 10)
                    .foregroundColor(.customSecondaryColor)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
            }
            Button {
                messagesVM.sendMessage(textInput)
                textInput = ""
            } label: {
                ZStack{
                    Text("Wyślij")
                        .foregroundColor(.accentColor)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).fill(.white).frame(height: 60))
                }
            }

        }.padding(.horizontal, 30)
            .frame(height: 80)
            .background(Color.customWhite)
    }
}
