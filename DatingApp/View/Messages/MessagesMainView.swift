//
//  MessagesMainView.swift
//  ChristianTinder
//
//  Created by Natanael Jop on 02/04/2022.
//

import SwiftUI

struct MessagesMainView: View {
    @Namespace var toggleAnim
    @State var toggledToLatest = true
    @EnvironmentObject var conversationVM: ConversationViewModel
    @EnvironmentObject var navBarVM: NavBarViewModel
    var body: some View {
        NavigationView{
                VStack{
                    toggleButton()
                    Spacer()
                    mainContent()
                }.background(Color.white)
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }.ignoresSafeArea()
        .background(Color.white)
    }
    fileprivate func toggleButton() -> some View {
        HStack{
            Button {
                withAnimation {
                    toggledToLatest = true
                }
            } label: {
                Text("Latest")
                    .foregroundColor(toggledToLatest ? .accentColor : .white)
                    .font(.system(size: 18, weight: toggledToLatest ? .bold : .regular, design: .rounded))
                    .padding()
                    .padding(.horizontal, 8)
                    .background(
                        ZStack {
                            if toggledToLatest {
                                Color.white.cornerRadius(20)
                                    .matchedGeometryEffect(id: "toggleAnim", in: toggleAnim, properties: .frame)
                            }else{
                                Color.clear
                            }
                        }
                    )
            }
            Button {
                withAnimation {
                    toggledToLatest = false
                }
            } label: {
                Text("Requests (3)")
                    .foregroundColor(!toggledToLatest ? .accentColor : .white)
                    .font(.system(size: 18, weight: !toggledToLatest ? .bold : .regular, design: .rounded))
                    .padding()
                    .padding(.horizontal, 8)
                    .background(
                        ZStack {
                            if !toggledToLatest {
                                Color.white.cornerRadius(20)
                                    .matchedGeometryEffect(id: "toggleAnim", in: toggleAnim, properties: .frame, isSource: true)
                            }else{
                                Color.clear
                            }
                        }
                    )
            }

        }.padding(8)
        .background(Color.lightPink.cornerRadius(20))
        .padding()
    }
    fileprivate func mainContent() -> some View {
        ZStack{
            CustomRectangle()
                .fill(Color.customWhite)
            ScrollView(showsIndicators: false) {
                LazyVStack{
                    ForEach(conversationVM.conversations) { conversation in
                        NavigationLink {
                            ConversationView(conversation: conversation)
                                .onAppear {navBarVM.show = false}
                                .onDisappear {withAnimation {navBarVM.show = true}}
                        } label: {
                            messageCell(conversation: conversation)
                        }

                    }
                }.padding(.top, 10)
                    .padding(20)
            }.cornerRadius(50)
        }
    }
    fileprivate func messageCell(conversation: ConversationModel) -> some View {
        HStack{
            compressImage(imageName: conversation.user.profile.image)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 60, height: 60)
            VStack(alignment: .leading, spacing: 5){
                Text(conversation.user.profile.name)
                Text(conversation.messages.isEmpty ? "" : conversation.messages.last!.textMessage)
                    .foregroundColor(.customSecondaryColor)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
            }.foregroundColor(.customBlue)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .padding(.horizontal, 10)
            Spacer()
            VStack(alignment: .trailing,spacing: 10) {
                Text("20 min ago")
                    .foregroundColor(.customSecondaryColor)
                    .font(.system(size: 10, weight: .bold, design: .rounded))

                Text("3")
                    .foregroundColor(.white)
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .padding(8)
                    .background(
                        Circle()
                            .fill(Color.accentColor)
                    )
            }
        }.padding()
            .background(Color.white.cornerRadius(20))
    }
}


struct CustomRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 50, height: 50))
        return Path(path.cgPath)
    }    
}

struct MessagesMainView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(conversation: ConversationModel(user: ProfileCard(profile: Profile(image: "user1", name: "Natan", description: "sada", age: 12, additionaImages: [""], perks: [""], localization: 2.0)), messages: [Message(isFromCurrentUser: true, textMessage: "sieam"), Message(isFromCurrentUser: false, textMessage: "elo"), Message(isFromCurrentUser: true, textMessage: "Co tam"), Message(isFromCurrentUser: false, textMessage: "a git, a tam?")]))
            .environmentObject(MessagesViewModel())
    }
}
