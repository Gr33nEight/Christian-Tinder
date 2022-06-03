//
//  HomeViewTopPart.swift
//  ChristianTinder
//
//  Created by Natanael Jop on 02/04/2022.
//

import SwiftUI

extension HomeMainView {
    func topPart() -> some View {
        VStack{
            searchBar()
                .padding(.top)
        }
    }
    
    fileprivate func locaction() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Location")
                .font(.system(size: 15, weight: .semibold, design: .rounded))
                .foregroundColor(.customSecondaryColor)
            HStack(spacing: 10){
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 20, weight: .black, design: .rounded))
                    .foregroundColor(.accentColor)
                HStack(spacing: 0){
                    Text("Rybnik, " )
                        .bold()
                    Text("Polska")
                }.font(.system(size: 20, design: .rounded))
                    .foregroundColor(.customBlue)
            }
        }
    }
    fileprivate func buttons() -> some View {
        HStack(spacing: 15){
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.customSecondaryColor)
                    .padding(10)
                    .background(Color.white.cornerRadius(15))
            }
            Button {
                
            } label: {
                Image(systemName: "bell.fill")
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.customSecondaryColor)
                    .padding(10)
                    .background(Color.white.cornerRadius(15))
            }

        }
    }
    fileprivate func searchBar() -> some View {
        HStack(spacing: 15) {
            customTextField()
                .foregroundColor(.customBlue)
            Button {
                if searchText.isEmpty {
                    withAnimation {
                        showFilterView = true
                    }
                } else {
                    var array = homeVM.profileCards
                    array = array.filter {
                        ($0.profile.name.lowercased().contains(searchText.lowercased())) || searchText == ""}
                    
                    filteredProfileCards = array
                    hideKeyboard()
                }
            } label: {
                if searchTextAnim.isEmpty {
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 25, weight: .semibold, design: .rounded))
                        .foregroundColor(showFilterView ? .customWhite : .white)
                        .padding(15)
                        .background(Color.accentColor.cornerRadius(15)
                                        .matchedGeometryEffect(id: "searchBarAnim", in: searchBarAnim, isSource: true)
                                        .matchedGeometryEffect(id: "filterButtonAnim", in: filterButtonAnim, isSource: true)
                        )
                }else{
                    Text("Search")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color.accentColor.cornerRadius(15).matchedGeometryEffect(id: "searchBarAnim", in: searchBarAnim, isSource: true))
                }
            }.zIndex(3)
            .onChange(of: searchText) { newValue in
                withAnimation {
                    searchTextAnim = searchText
                }
            }
        }
    }
    
    fileprivate func customTextField() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.horizontal, 10)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(Color.customSecondaryColor)
            ZStack(alignment: .leading){
                if searchText.isEmpty{
                    Text("Search Partner")
                        .foregroundColor(Color.customSecondaryColor)
                }
                TextField("", text: $searchText)
                    .onSubmit {
                        if searchText.isEmpty {
                            withAnimation {
                                filteredProfileCards = homeVM.profileCards
                            }
                        }
                    }
                
            }
            Spacer()
        }.font(.system(size: 15, weight: .semibold, design: .rounded))
        .padding(18)
            .background(
                Color.white
                    .cornerRadius(20)
            )

    }
    
    func filterView() -> some View {
        Color.accentColor.cornerRadius(15)
            .zIndex(3)
            .scaledToFit()
            .animation(nil, value: 0)
            .matchedGeometryEffect(id: "filterButtonAnim", in: filterButtonAnim, properties: .frame, anchor: .center, isSource: true)
            .onTapGesture {
                withAnimation {
                    showFilterView = false
                }
            }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct HomeMainView_Previews2: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
