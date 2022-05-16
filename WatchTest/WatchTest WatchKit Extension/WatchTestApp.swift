//
//  WatchTestApp.swift
//  WatchTest WatchKit Extension
//
//  Created by Frank Chu on 4/28/22.
//

import SwiftUI

@main
struct WatchTestApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
