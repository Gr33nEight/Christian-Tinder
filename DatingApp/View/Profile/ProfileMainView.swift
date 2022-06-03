//
//  ProfileMainVIew.swift
//  ChristianTinder
//
//  Created by Natanael Jop on 02/04/2022.
//

import SwiftUI

struct ProfileMainView: View {
    var body: some View {
        ZStack{
            Color.customWhite
            Text("Profile View")
                .foregroundColor(.accentColor)
        }.ignoresSafeArea()
    }
}

struct ProfileMainVIew_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMainView()
    }
}
