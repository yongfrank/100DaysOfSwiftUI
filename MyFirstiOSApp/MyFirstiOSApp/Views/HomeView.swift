//
//  HomeView.swift
//  MyFirstiOSApp
//
//  Created by Frank Chu on 4/19/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(items) { item in
                            NavigationLink(destination: DetailView()) {
                                CardView(item: item)
                            }
                        }
                    }
                    .padding()
                    
                }
                Text("Recent course")
                    .font(.subheadline).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                    ForEach(items) { item in
                        NavigationLink(destination: DetailView()) {
                            SmallCardView(item: item)
                        }
                        
                    }
                }
                .padding()
            }
            .navigationTitle("Learn SwiftUI")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
