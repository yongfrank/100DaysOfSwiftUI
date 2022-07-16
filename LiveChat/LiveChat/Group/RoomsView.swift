//
//  RoomsView.swift
//  LiveChat
//
//  Created by Frank Chu on 7/7/22.
//

import SwiftUI

struct RoomsView: View {
    let username: String
    let rooms = ["Java", "Kotlin", "Swift", "Python"]
    var body: some View {
        List {
            Text(username)
            ForEach(rooms, id: \.self) { room in
                NavigationLink(destination: Text(room)) {
                    Text(room)
                }
            }
        }
        .navigationTitle("Rooms")
        .navigationBarTitleDisplayMode(.inline)
    }
}



struct RoomsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RoomsView(username: "hi")
        }
    }
}
