//
//  MemeCreatorByFrankApp.swift
//  MemeCreatorByFrank
//
//  Created by Frank Chu on 4/7/22.
//

import SwiftUI

@main
struct MemeCreatorByFrankApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MemeCreator()
            }
            .navigationViewStyle(.stack)
        }
    }
}
