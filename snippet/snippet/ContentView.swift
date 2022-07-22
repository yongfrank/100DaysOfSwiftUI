//
//  ContentView.swift
//  snippet
//
//  Created by Frank Chu on 7/16/22.
//

import SwiftUI
import UIKit

struct ContentView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State private var time = Date.now
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("\(time.formatted(date: .numeric, time: .standard))")
        }
        .onReceive(timer) { time in
            self.time = time
        }
        .onAppear {
            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

