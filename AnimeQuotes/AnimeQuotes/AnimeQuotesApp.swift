//
//  AnimeQuotesApp.swift
//  AnimeQuotes
//
//  Created by Frank Chu on 6/12/22.
//

import SwiftUI

@main
struct AnimeQuotesApp: App {
    
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
