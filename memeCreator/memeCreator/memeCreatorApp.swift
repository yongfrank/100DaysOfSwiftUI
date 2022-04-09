//
//  memeCreatorApp.swift
//  memeCreator
//
//  Created by Frank Chu on 4/7/22.
//

import SwiftUI

@main
struct memeCreatorApp: App {
    @StateObject private var fetcher = PandaCollectionFetcher()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MemeCreator()
                    .environmentObject(fetcher)
            }
            .navigationViewStyle(.stack)
        }
    }
}
