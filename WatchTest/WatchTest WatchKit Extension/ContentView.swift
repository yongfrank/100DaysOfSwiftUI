//
//  ContentView.swift
//  WatchTest WatchKit Extension
//
//  Created by Frank Chu on 4/28/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Scene padding")
                    
                    .border(.red)
                Text("Regular padding")
                    .padding(.horizontal)
                    .border(.green)
                Text("Text with no padding")
                    .border(.blue)
                Button("Button") { }
            }
            .scenePadding(.horizontal)
            .navigationTitle("Hello World")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
