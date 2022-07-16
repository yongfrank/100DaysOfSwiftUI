//
//  ContentView.swift
//  ExploringFileManager
//
//  Created by Frank Chu on 7/15/22.
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
        .onAppear {
            /// FileManager Swift 5 教程（2022，Xcode 12，iOS） - 适用于初学者的 iOS
            /// https://www.youtube.com/watch?v=pUAcMruIBGg
            ///
            guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                print("DEBUG: Error in url")
                return
            }
            print("DEBUG: url is", url)

            let fileUrl = url.appending(path: "ios-Academy")
            if FileManager.default.fileExists(atPath: fileUrl.path()) {
                do {
                    try FileManager.default.removeItem(at: fileUrl)
                    print("DEBUG: remove success!")
                } catch {
                    print("DEBUG: remove fail")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
