//
//  ContentView.swift
//  Project12-NSCoding
//
//  Created by Frank Chu on 4/30/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            let dict = ["Name": "Frank", "Gender": "Male"]
            UserDefaults.standard.set(dict, forKey: "frank")
            print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//            print(UserDefaults.standard.dictionary(forKey: "frank"))
            UserDefaults.standard.set(["hello", "world"], forKey: "ok")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
