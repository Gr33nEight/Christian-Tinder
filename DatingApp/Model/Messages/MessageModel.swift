//
//  Message.swift
//  DatingApp
//
//  Created by Natanael Jop on 05/04/2022.
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID().uuidString
    let isFromCurrentUser: Bool
    let textMessage: String
}

