//
//  WorldCupScoreBoardAppApp.swift
//  WorldCupScoreBoardApp
//
//  Created by Frank Chu on 11/23/22.
//

import SwiftUI

@main
struct WorldCupScoreBoardAppApp: App {
    @StateObject var env = GameScoreStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(env)
        }
    }
}
