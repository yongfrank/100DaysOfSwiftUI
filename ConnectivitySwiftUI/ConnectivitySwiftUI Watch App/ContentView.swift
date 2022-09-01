//
//  ContentView.swift
//  ConnectivitySwiftUI Watch App
//
//  Created by Frank Chu on 8/26/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = ViewModelWatch()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text(self.model.messageText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
