//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Frank Chu on 4/5/22.
//

import SwiftUI

@main
struct BookwormApp: App {
    
    @StateObject private var dataControllerByFrankInApp: DataControllerCreatedByFrank = DataControllerCreatedByFrank()
    
    var body: some Scene {
        WindowGroup {
//            So, the job of the view context is to let us work with all our data in memory, which is much faster than constantly reading and writing data to disk
            ContentView()
                .environment(\.managedObjectContext, dataControllerByFrankInApp.containerCreatedByFrank.viewContext)
        }
    }
}
