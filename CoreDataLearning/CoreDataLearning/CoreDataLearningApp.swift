//
//  CoreDataLearningApp.swift
//  CoreDataLearning
//
//  Created by Frank Chu on 3/9/23.
//

import SwiftUI

@main
struct CoreDataLearningApp: App {
    let persistenceController: PersistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
