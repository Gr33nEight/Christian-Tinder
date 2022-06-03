//
//  LikesViewModel.swift
//  DatingApp
//
//  Created by Natanael Jop on 06/04/2022.
//

import SwiftUI

class LikesViewModel: ObservableObject {
    
    @Published var likeCards = [LikeCard]()
    @Published var matchCards = [LikeCard]()
    
    var homeVM: HomeViewModel
    
    init(homeVM: HomeViewModel){
        self.homeVM = homeVM
        
        for i in homeVM.profileCards.indices {
            if i % 11 == 0 {
                matchCards.append(LikeCard(profile: homeVM.profileCards[i]))
            }
            else if i % 4 == 0 {
                likeCards.append(LikeCard(profile: homeVM.profileCards[i]))
            }
        }
        
        
    }
    
    
}
