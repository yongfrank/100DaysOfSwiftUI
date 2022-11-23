//
//  ContentView.swift
//  iOS Academy
//
//  Created by Frank Chu on 10/9/22.
//

import SwiftUI

struct Option {
    let title: String
    let imageName: String
    
    static let EXAMPLE: [Option] = [
        .init(title: "Home", imageName: "house"),
        .init(title: "About", imageName: "info.circle"),
        .init(title: "Settings", imageName: "gear"),
        .init(title: "Social", imageName: "message"),
    ]
}

class ViewModel {
    @Published var options: [Option] = Option.EXAMPLE
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            ListView()
            
            MainView()
        }
        .frame(minWidth: 600, minHeight: 400)
    }
}

struct ListView: View {
    var body: some View {
        Text("HI")
    }
}

struct MainView: View {
    var body: some View {
        Text("Main")
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
