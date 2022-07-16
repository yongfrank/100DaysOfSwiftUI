//
//  ContentView.swift
//  LiveChat
//
//  Created by Frank Chu on 7/7/22.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    var body: some View {
        NavigationView {
            if username == "" {
                LoginView(username: $username)
            } else {
                RoomsView(username: username)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
