//
//  CustomTextField.swift
//  ChristianTinder
//
//  Created by Natanael Jop on 02/04/2022.
//

import SwiftUI

struct CustomTextField: View {
    
    let placeholder: Text
    let image: String
    
    @Binding var text: String
    
    var body: some View {
        HStack{
            Image(systemName: image)
                .padding(.horizontal)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(Color.customSecondaryColor)
            ZStack(alignment: .leading){
                if text.isEmpty{
                    placeholder
                        .foregroundColor(Color.customSecondaryColor)
                }
                TextField("", text: $text)
                
            }
            Spacer()
        }.font(.system(size: 15, weight: .semibold, design: .rounded))
        .padding(20)
            .background(
                Color.white
                    .cornerRadius(20)
            )
    }
}
