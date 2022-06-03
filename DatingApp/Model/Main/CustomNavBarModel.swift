//
//  CustomNavBarModel.swift
//  ChristianTinder
//
//  Created by Natanael Jop on 02/04/2022.
//

import SwiftUI

struct NavBarModel: Identifiable {
    var id = UUID()
    let type: NavBarViewType
    let view: AnyView
}

enum NavBarViewType: String {
    case home, likes, messages, profile
    
    var icon: String {
        switch self {
        case .home:
            return "home"
        case .likes:
            return "heart"
        case .messages:
            return "bubble"
        case .profile:
            return "person"
        }
    }
}

class NavBarViewModel: ObservableObject {
    @Published var navBarModels: [NavBarModel] = [
        NavBarModel(type: .home, view: AnyView(ContentView())),
        NavBarModel(type: .likes, view: AnyView(ContentView())),
        NavBarModel(type: .messages, view: AnyView(ContentView())),
        NavBarModel(type: .profile, view: AnyView(ContentView()))
    ]
    @Published var show = true
}
