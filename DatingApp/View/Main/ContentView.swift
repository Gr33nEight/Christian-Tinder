//
//  ContentView.swift
//  ChristianTinder
//
//  Created by Natanael Jop on 02/04/2022.
//

import SwiftUI

struct ContentView: View {
    @State var selectedType: NavBarViewType = .home
    @EnvironmentObject var viewDelegatorVM: AuthViewDelegator
    var body: some View {
        Group {
            if viewDelegatorVM.showMainView {
                VStack{
                    viewDelegator()
                    Spacer()
                    CustomNavBarView(selectedType: $selectedType)
                }.background(Color.customWhite)
                .edgesIgnoringSafeArea(.bottom)
            }else if viewDelegatorVM.showCreateAccount {
                CreateAccountMainView()
            }else {
                WalkthroughMainView()
            }
        }
    }
}

extension ContentView {
    fileprivate func viewDelegator() -> some View {
        return (
            Group {
                switch(selectedType){
                case .home: HomeMainView()
                case .likes: LikesMainView()
                case .messages: MessagesMainView()
                case .profile: ProfileMainView()
                }
            }
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
