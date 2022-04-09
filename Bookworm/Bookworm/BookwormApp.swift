//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Frank Chu on 4/5/22.
//

import SwiftUI

@main
struct BookwormApp: App {
    
    @StateObject private var dataControllerByFrankInApp = DataControllerCreatedByFrank()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataControllerByFrankInApp.containerCreatedByFrank.viewContext)
        }
    }
}
