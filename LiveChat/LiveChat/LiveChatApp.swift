//
//  LiveChatApp.swift
//  LiveChat
//
//  Created by Frank Chu on 7/7/22.
//

import SwiftUI
import RealmSwift

let realmApp = RealmSwift.App(id: "livechat-rxkgc")

@main
struct LiveChatApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
