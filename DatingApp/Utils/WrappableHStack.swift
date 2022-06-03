//
//  WrappableHStack.swift
//  ChristianTinder
//
//  Created by Natanael Jop on 04/04/2022.
//

import SwiftUI

struct WrappableHstack: View {
    @State var totalHeight: CGFloat = CGFloat.zero
    var items: [String]
    var bgcolor: Color
    var txtcolor: Color
    
    var body: some View {
        let stack = VStack {
            GeometryReader { geometry in
                self.content(in: geometry)
            }
        }
        return Group {
            stack.frame(height: totalHeight) 
        }
    }
    
    private func content(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            ForEach(self.items, id: \.self) { item in
                self.item(for: item)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if item == self.items.last {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if item == self.items.last {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geo -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = geo.frame(in: .local).size.height
            }
            return .clear
        }
    }
    private func item(for text: String) -> some View {
        Text(text)
            .padding(.all, 5)
            .padding(.horizontal, 7)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .background(bgcolor)
            .foregroundColor(txtcolor)
            .cornerRadius(15)
    }
}

struct WrappableHstackForInterests: View {
    @State var totalHeight: CGFloat = CGFloat.zero
    @Binding var interests: [Interest]
    @EnvironmentObject var authVM: AuthViewModel
    var body: some View {
        let stack = VStack {
            GeometryReader { geometry in
                self.content(in: geometry)
            }
        }
        return Group {
            stack.frame(height: totalHeight)
        }
    }
    
    private func content(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            ForEach(interests.indices, id: \.self) { idx in
                self.item(idx: idx)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if interests[idx] == self.interests.last {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if interests[idx] == self.interests.last {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geo -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = geo.frame(in: .local).size.height
            }
            return .clear
        }
    }
    private func item(idx: Int) -> some View {
        Button {
            withAnimation {
                interests[idx].isPicked.toggle()
                if interests[idx].isPicked {
                    authVM.accountInformation.interestsInformation.interests.append(interests[idx])
                    if authVM.accountInformation.interestsInformation.interests.count >= 3 {
                        authVM.accountInformation.interestsInformation.isDone = true
                    }
                }else{
                    authVM.accountInformation.interestsInformation.interests = authVM.accountInformation.interestsInformation.interests.filter({$0 == interests[idx]})
                    if authVM.accountInformation.interestsInformation.interests.count < 3 {
                        authVM.accountInformation.interestsInformation.isDone = false
                    }
                }
            }
        } label: {
            HStack{
                Image(systemName: interests[idx].image)
                    .foregroundColor(interests[idx].isPicked ? .customWhite : .lightPink)
                Text(interests[idx].name)
                    .foregroundColor(interests[idx].isPicked ? .customWhite : .customSecondaryColor)
            }
            .font(.system(size: 16, weight: .semibold, design: .rounded))
            .padding(20)
            .background(interests[idx].isPicked ? Color.accentColor : Color.white)
            .cornerRadius(10)
            .shadow(color: interests[idx].isPicked ? .accentColor.opacity(0.5) : .black.opacity(0.1), radius: 20)
        }

    }
}
