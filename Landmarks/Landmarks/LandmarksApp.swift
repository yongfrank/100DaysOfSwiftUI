//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Frank Chu on 3/13/22.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
