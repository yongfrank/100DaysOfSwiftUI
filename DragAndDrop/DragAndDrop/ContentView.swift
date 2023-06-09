//
//  ContentView.swift
//  DragAndDrop
//
//  Created by Frank Chu on 4/9/23.
//

import SwiftUI
import RegexBuilder

struct ContentView: View {
    let a = /[a-z]/
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
