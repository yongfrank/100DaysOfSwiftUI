//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Frank Chu on 6/16/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        NavigationView {
//            Text("HI")
//            NavigationView {
//                NavigationLink {
//                    Text("HI")
//                        .navigationBarHidden(true)
//                } label: {
//                    Text("push me")
//                }
//            }
//        }
        NavigationView {
            NavigationLink {
                Text("Hello world!")
                    .navigationBarHidden(true)
            } label: {
                Text("Hello, World!")
            }
            .navigationTitle("Primary")
            Text("Secondary")
            Text("Tertiary")
        }
//        NavigationSplitView {
//            Text("Hello")
//                .navigationTitle("Primary")
//        } detail: {
//            Text("HI")
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
