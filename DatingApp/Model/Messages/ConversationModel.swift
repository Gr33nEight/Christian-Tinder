//
//  Conversation.swift
//  DatingApp
//
//  Created by Natanael Jop on 06/04/2022.
//

import Foundation

struct ConversationModel: Identifiable {
    let id = UUID().uuidString
    let user: ProfileCard
    let messages: [Message]
}
