//
//  CreateAccountMainView.swift
//  DatingApp
//
//  Created by Natanael Jop on 14/04/2022.
//

import SwiftUI

struct CreateAccountMainView: View {
    let arrayOfViews: [AnyView] = [AnyView(CreateAuthPage()), AnyView(MediaAuthPage()), AnyView(InterestsAuthPage()), AnyView(IdealMatchAuthPage()), AnyView(CheckListAuthPage())]
    @Namespace var indexanim
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var viewDelegator: AuthViewDelegator
    var body: some View {
        VStack {
            arrayOfViews[authVM.currentIndex]
            if authVM.currentIndex == arrayOfViews.count - 1 {
                Button {
                    viewDelegator.showMainView = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.accentColor)
                        Text("Finish Setup")
                            .foregroundColor(.white)
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                    }.frame(height: 70)
                        .padding()
                        .padding(.bottom, 10)
                        .shadow(color: .accentColor, radius: 10)
                }

            }else{
                HStack {
                    HStack(spacing: 10){
                        ForEach(0..<arrayOfViews.count, id:\.self) { num in
                            if num == authVM.currentIndex {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.accentColor)
                                    .matchedGeometryEffect(id: "indexanim", in: indexanim)
                                    .frame(width: 30, height: 10)
                            }else{
                                Circle()
                                    .frame(width: 10, height: 10)
                            }
                            
                        }
                    }
                    Spacer()
                    HStack(spacing: 15){
                        Button {
                            if authVM.currentIndex == 0 {
                                if authVM.accountInformation.mainInformation.fullname.isEmpty || authVM.accountInformation.mainInformation.email.isEmpty || authVM.accountInformation.mainInformation.password.isEmpty || authVM.accountInformation.mainInformation.phone.isEmpty || authVM.accountInformation.mainInformation.location.isEmpty {
                                    authVM.accountInformation.mainInformation.isDone = false
                                }else{
                                    authVM.accountInformation.mainInformation.isDone = true
                                }
                            }
                            
                            withAnimation {
                                authVM.currentIndex += 1
                            }
                        } label: {
                            Text("Next")
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                            Image(systemName: "arrow.right")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .padding(15)
                                .foregroundColor(.white)
                                .background(Circle().fill(Color.accentColor))
                        }

                    }.foregroundColor(.accentColor)
                }.padding(.horizontal, 20)
                    .padding()
            }
        }.background(Color.customWhite.ignoresSafeArea())
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct CreateAccountMainView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountMainView()
            .environmentObject(AuthViewModel())
    }
}
