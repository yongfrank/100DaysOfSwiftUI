//
//  ContentView.swift
//  Increment
//
//  Created by Frank Chu on 6/28/22.
//

import SwiftUI

struct LandingView: View {
    @State private var isActive = false
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(height: proxy.size.height * 0.25)

                    Text("Increment")
                        .font(.system(size: 64, weight: .medium))
                        .foregroundColor(.white)

                    Spacer()
                    
                    NavigationLink(isActive: $isActive) {
                        CreateView()
                    } label: {
                        Button {
                            isActive = true
                        } label: {
                            HStack(spacing: 15) {
                                Spacer()
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                                Text("Create a challenge")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        .padding(15)
                        .buttonStyle(PrimaryButtonStyle())
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image("running")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(Color.black.opacity(0.4))
                        .frame(width: proxy.size.width)
                        .offset(x: -30, y: 0)
                        .ignoresSafeArea()
                )
            }
            .navigationBarHidden(true)
        }
        .accentColor(.primary)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView().previewDevice("iPhone 13 Pro")
        LandingView().previewDevice("iPhone 8")
        LandingView().previewDevice("iPhone 13 Pro Max")
    }
}
