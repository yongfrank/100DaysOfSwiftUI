//
//  ContentView.swift
//  Douyin
//
//  Created by Frank Chu on 5/11/23.
//

import SwiftUI

struct ContentView: View {
    var dismiss: () -> Void = {}
    var body: some View {
        Text("Hi")
        Button("Press Me") {
            dismiss()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
