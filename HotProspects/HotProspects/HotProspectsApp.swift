//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Frank Chu on 4/12/22.
//

import SwiftUI

@main
struct HotProspectsApp: App {

    @StateObject var prospects = Prospects()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(prospects)
        }
    }
}
