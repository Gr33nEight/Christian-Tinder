//
//  MessagesViewModel.swift
//  DatingApp
//
//  Created by Natanael Jop on 05/04/2022.
//

import Foundation
import SwiftUI


class ConversationViewModel: ObservableObject {
    @Published var conversations = [ConversationModel]()
    var homeVM: HomeViewModel
    var messagesVM: MessagesViewModel
    
    
    init(homeVM: HomeViewModel, messagesVM: MessagesViewModel) {
        
        self.homeVM = homeVM
        self.messagesVM = messagesVM
        
        for i in homeVM.profileCards {
            conversations.append(ConversationModel(user: i, messages: messagesVM.messages))
        }
    }
}

class MessagesViewModel: ObservableObject {
    
    @Published var messages = [Message]()
    
    init() {
        messages = mockChat
    }
    
    var mockChat: [Message] {
        [
            .init(isFromCurrentUser: false, textMessage: "Siema"),
            .init(isFromCurrentUser: true, textMessage: "Hejka"),
            .init(isFromCurrentUser: false, textMessage: "Co tam u ciebie"),
            .init(isFromCurrentUser: false, textMessage: "?"),
            .init(isFromCurrentUser: true, textMessage: "A dobrze, jakoś żyję, bardzo dużo pracy mam ://"),
            .init(isFromCurrentUser: true, textMessage: "A tam?"),
            .init(isFromCurrentUser: false, textMessage: "A też dobrze, dziękuje, ja na szczęście już zrobiłem wszystko co miałem dzisiaj zaplanowane"),
            .init(isFromCurrentUser: true, textMessage: "Zaaazdrooo"),
            .init(isFromCurrentUser: true, textMessage: "Serioo tak bym chciał już skońcyzć i miec wolne"),
            .init(isFromCurrentUser: false, textMessage: "Współczuje :((")
        ]
    }
    
    func sendMessage(_ messageText: String) {
        if !messageText.isEmpty {
            let message = Message(isFromCurrentUser: true, textMessage: messageText)
            messages.append(message)
        }
    }
}
