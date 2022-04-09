//
//  SandwichesApp.swift
//  Shared
//
//  Created by Frank Chu on 4/9/22.
//

import SwiftUI

@main
struct SandwichesApp: App {
    @StateObject var store = SandwichStore()

    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
