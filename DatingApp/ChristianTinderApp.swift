//
//  ChristianTinderApp.swift
//  ChristianTinder
//
//  Created by Natanael Jop on 02/04/2022.
//

import SwiftUI

@main
struct ChristianTinderApp: App {
    @StateObject var navBarVM = NavBarViewModel()
    @StateObject var homeVM = HomeViewModel()
    @StateObject var messagesVM = MessagesViewModel()
    @StateObject var conversationVM = ConversationViewModel(homeVM: HomeViewModel(), messagesVM: MessagesViewModel())
    @StateObject var likesVM = LikesViewModel(homeVM: HomeViewModel())
    @StateObject var authVM = AuthViewModel()
    @StateObject var viewDelegator = AuthViewDelegator()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navBarVM)
                .environmentObject(homeVM)
                .environmentObject(messagesVM)
                .environmentObject(conversationVM)
                .environmentObject(likesVM)
                .environmentObject(viewDelegator)
                .environmentObject(authVM)
        }
    }
}
