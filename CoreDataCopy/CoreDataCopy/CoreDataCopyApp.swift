//
//  CoreDataCopyApp.swift
//  CoreDataCopy
//
//  Created by Frank Chu on 4/10/22.
//

import SwiftUI

@main
struct CoreDataCopyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
