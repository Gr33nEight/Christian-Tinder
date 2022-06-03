//
//  CustomNavBarView.swift
//  ChristianTinder
//
//  Created by Natanael Jop on 02/04/2022.
//

import SwiftUI

struct CustomNavBarView: View {
    @EnvironmentObject var navBarVM: NavBarViewModel
    @Binding var selectedType: NavBarViewType
    @Namespace var anim
    var body: some View {
        if navBarVM.show {
            HStack{
                ForEach(navBarVM.navBarModels){ model in
                    CustomNavBarIcon(model: model, anim: anim, selectedType: $selectedType)
                        .onTapGesture {
                            withAnimation {
                                selectedType = model.type
                            }
                        }
                }.padding(.vertical, 12)
            }.background(Color.customWhite)
        }
    }
}

struct CustomNavBarIcon: View {
    var model: NavBarModel
    var anim: Namespace.ID
    
    @Binding var selectedType: NavBarViewType
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Image(model.type.icon)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(model.type == selectedType ? .customPink : .customGray)
                    .frame(width: 25, height: 25)
                Spacer()
            }
            if model.type == selectedType {
                Circle()
                    .fill(Color.lightPink)
                    .matchedGeometryEffect(id: "anim", in: anim, isSource: true)
                    .frame(width: 7, height: 7)
            }
        }

    }
}

