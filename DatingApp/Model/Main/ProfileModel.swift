//
//  ProfileModel.swift
//  DatingApp
//
//  Created by Natanael Jop on 14/04/2022.
//

import Foundation

struct Profile: Identifiable {
    let id = UUID().uuidString
    var image: String
    var name: String
    var description: String
    var age: Int
    var additionaImages: [String]
    var perks: [String]
    var localization: Double
}
