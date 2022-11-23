//
//  TimeTrackingApp.swift
//  TimeTracking
//
//  Created by Frank Chu on 10/22/22.
//

import SwiftUI

@main
struct TimeTrackingApp: App {
    
    @State private var showSheet: Bool = false
    @ObservedObject var env: GlobalEnvironment = GlobalEnvironment()
    
    var body: some Scene {
        WindowGroup {
            ContentView(showSheet: $showSheet)
                .environmentObject(env)
                .preferredColorScheme(.dark)
        }
        .commands {
            AppCommands(showSheet: $showSheet)
        }
    }
    
}

struct AppCommands: Commands {
    @Binding var showSheet: Bool
    @CommandsBuilder var body: some Commands {
        CommandGroup(replacing: CommandGroupPlacement.newItem) {
            Button {
                showSheet.toggle()
            } label: {
                Text("Action")
            }
            .keyboardShortcut("p")
            Button("HI") {}
        }
        CommandGroup(replacing: CommandGroupPlacement.appSettings) {
            Button("App settings replace"){}
        }
//        CommandMenu("File") {
//
//        }
    }
}
