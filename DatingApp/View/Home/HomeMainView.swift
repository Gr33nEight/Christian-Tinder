//
//  HomeMainView.swift
//  ChristianTinder
//
//  Created by Natanael Jop on 02/04/2022.
//

import SwiftUI

struct HomeMainView: View {
    @Namespace var showProfileViewAnim
    @Namespace var searchBarAnim
    @Namespace var filterButtonAnim
    
    @State var disableButtons = false
    @State var decided = false
    @State var currentIndex = 1
    @State var showFilterView = false
    @State var searchTextAnim = ""
    @State var searchText = ""
    @State var isLiked = false
    @State var filteredProfileCards: [ProfileCard] = []
    @State var showProfileView = false
    
    @EnvironmentObject var homeVM: HomeViewModel
    @EnvironmentObject var navBarVM: NavBarViewModel
    @EnvironmentObject var messagesVM: MessagesViewModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                    ZStack{
                        Color.customWhite.ignoresSafeArea()
                        VStack{
                            topPart()
                                .padding(.top, 35)
                            Spacer()
                            cardDelegator()
                        }.padding(.horizontal, 20)
                            .edgesIgnoringSafeArea(.top)
                            .padding(.bottom, 40)
                        if showFilterView {
                            VStack{
                                HStack{
                                    filterView()
                                }.padding()
                                Spacer()
                            }
                        }
                    }
                    .zIndex(4)
                if showProfileView {
                    profileView()
                        .zIndex(5)
                        
                }
                
            }
            .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }.ignoresSafeArea()
            .onAppear {
                filteredProfileCards = homeVM.profileCards
            }
    }
}

struct HomeMainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
