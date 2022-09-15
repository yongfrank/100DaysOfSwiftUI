//
//  CustomTab.swift
//  FoodDeliveryApp
//
//  Created by Frank Chu on 9/14/22.
//

import SwiftUI

enum CustomTabEnumeration: String, CaseIterable {
    case home = "house"
    case explore = "safari"
    case favorite = "heart"
    case profile = "person"
}

struct CustomTab: View {
    
    @State private var currentTab: CustomTabEnumeration = .home
    @Namespace var animation
    
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                customTabBar()
            }
            .navigationTitle("Custom Tab Bar")
        }
    }
    
    @ViewBuilder
    func customTabBar() -> some View {
        HStack {
            ForEach(CustomTabEnumeration.allCases, id: \.self) { item in
                VStack {
                    Image(systemName: item.rawValue)
                        .font(.title)
                        .foregroundColor(currentTab == item ? .black : .gray.opacity(0.6))
                    
                    if currentTab == item {
                        Circle()
                            .frame(width: 5, height: 5)
                            .offset(y: 10)
                            .matchedGeometryEffect(id: "CustomTabEnumeration", in: animation)
                    }
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
//                    withAnimation(.easeOut) {
                        currentTab = item
//                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}

struct CustomTab_Previews: PreviewProvider {
    static var previews: some View {
        CustomTab()
    }
}
