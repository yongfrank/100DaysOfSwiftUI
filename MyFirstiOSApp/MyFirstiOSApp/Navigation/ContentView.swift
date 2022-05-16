//
//  ContentView.swift
//  MyFirstiOSApp
//
//  Created by Frank Chu on 4/19/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            DetailView()
                .tabItem {
                    Image(systemName: "eyes.inverse")
                    Text("Home")
                }
            ListView()
                .tabItem {
                    Image(systemName: "graduationcap")
                    Text("List")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

