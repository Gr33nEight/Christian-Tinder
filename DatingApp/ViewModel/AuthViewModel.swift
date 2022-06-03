//
//  AuthViewModel.swift
//  DatingApp
//
//  Created by Natanael Jop on 16/04/2022.
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    
    @Published var accountInformation: UserInformation = UserInformation(
        mainInformation: MainInformation(fullname: "", email: "", password: "", phone: "", location: ""),
        mediaInformation: MediaInformation(images: [""]),
        idealMatchInformation: IdealMatchInformation(typeOfMatch: ""),
        interestsInformation: InterestsInformation(interests: [])
    )
    @Published var currentIndex = 0
}



struct UserInformation: Identifiable {
    let id = UUID().uuidString
    var mainInformation: MainInformation
    var mediaInformation: MediaInformation
    var idealMatchInformation: IdealMatchInformation
    var interestsInformation: InterestsInformation
}

struct MainInformation {
    var fullname: String
    var email: String
    var password: String
    var phone: String
    var location: String
    var isDone: Bool = false
    var headline: String = "Name"
    var subheadline: String = "Enter your full name."
    var viewIndex = 0
}

struct MediaInformation {
    var images: [String]
    var isDone: Bool = false
    var headline: String = "Media"
    var subheadline: String = "Upload your best photos."
    var viewIndex = 1
}

struct IdealMatchInformation {
    var typeOfMatch: String
    var isDone: Bool = false
    var headline: String = "Ideal Match"
    var subheadline: String = "What are you looking for?"
    var viewIndex = 3
}

struct InterestsInformation {
    var interests: [Interest]
    var isDone: Bool = false
    var headline: String = "Interests"
    var subheadline: String = "Find users with similar interests."
    var viewIndex = 2
}
