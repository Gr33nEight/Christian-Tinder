//
//  FirstWalkthrough.swift
//  DatingApp
//
//  Created by Natanael Jop on 14/04/2022.
//

import SwiftUI

struct CreateAuthPage: View {
    @EnvironmentObject var authVM: AuthViewModel
    var body: some View {
        VStack(alignment: .leading){
            topPart()
            centerPart()
            Spacer()
            
        }.background(Color.customWhite.ignoresSafeArea())
    }
    
    fileprivate func topPart() -> some View {
        VStack(alignment: .leading){
            HStack(spacing: 15){
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.darkPink)
                    .padding()
                    .background(Circle().fill(Color.lightPink))
                Text("Create")
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
                    .foregroundColor(.customBlue)
                Spacer()
            }
            Text("Create your free account today and start matching with singles in your area")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.customSecondaryColor)
                .multilineTextAlignment(.leading)
                .padding(.vertical, 10)
        }.padding(30)
    }
    
    fileprivate func centerPart() -> some View {
        VStack(spacing: 20){
            customTextField(textInput: $authVM.accountInformation.mainInformation.fullname, type: .fullname)
            customTextField(textInput: $authVM.accountInformation.mainInformation.email, type: .email)
            customTextField(textInput: $authVM.accountInformation.mainInformation.password, type: .password)
            customTextField(textInput: $authVM.accountInformation.mainInformation.phone, type: .phone)
            customTextField(textInput: $authVM.accountInformation.mainInformation.location, type: .location)
        }.padding(10)
            .padding(.horizontal)
    }
    
    fileprivate func customTextField(textInput: Binding<String>, type: TextFieldType) -> some View {
        HStack{
            Image(systemName: type.image)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.horizontal, 7)
                .foregroundColor(.customBlue)
            ZStack(alignment: .leading){
                if textInput.wrappedValue.isEmpty {
                    Text(type.placeholder)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.customSecondaryColor)
                }
                if type == .password {
                    SecureField("", text: textInput)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.customBlue)
                }else{
                    TextField("", text: textInput)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.customBlue)
                }
            }
            Spacer()
            if type == .password {
                
            }
            Image(systemName: "checkmark")
                .foregroundColor(textInput.wrappedValue.isEmpty ? .customBlue : .customWhite)
                .font(.system(size: 9, weight: .bold, design: .rounded))
                .padding(8)
                .background(Circle().fill(textInput.wrappedValue.isEmpty ? Color.customSecondaryColor : Color.accentColor))
        }.padding(25)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
        .shadow(color: .black.opacity(0.1), radius: 30)
    }
}

struct FirstAuthPage_Previews: PreviewProvider {
    static var previews: some View {
        CreateAuthPage()
    }
}


enum TextFieldType: String {
    case fullname, email, password, phone, location
    
    var placeholder: String {
        switch self {
        case .fullname: return "Full name"
        case .email: return "Email"
        case .password: return "Password"
        case .phone: return "Phone number"
        case .location: return "Location"
        }
    }
    
    var image: String {
        switch self {
        case .fullname: return "person"
        case .email: return "envelope"
        case .password: return "lock"
        case .phone: return "phone"
        case .location: return "mappin.and.ellipse"
        }
    }
}
