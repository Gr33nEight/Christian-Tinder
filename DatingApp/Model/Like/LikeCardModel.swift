//
//  LikeCardModel.swift
//  DatingApp
//
//  Created by Natanael Jop on 06/04/2022.
//

import SwiftUI

struct LikeCard: Identifiable {
    let id = UUID().uuidString
    var profile: ProfileCard
    var offset: CGFloat = 0.0
    var show: Bool = true
    var dragDisabled: Bool = false
}


