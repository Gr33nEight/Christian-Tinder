//
//  HomeViewModel.swift
//  ChristianTinder
//
//  Created by Natanael Jop on 03/04/2022.
//

import SwiftUI

struct ProfileCard: Identifiable {
    var id = UUID().uuidString
    var profile: Profile
    var offset: CGFloat = 0.0
    var show: Bool = true
    var dragDisabled: Bool = false
}
