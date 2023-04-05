//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Frank Chu on 4/7/22.
//

import SwiftUI
import CoreData

@main
struct CoreDataProjectApp: App {
    let persistenceController: DataController = DataController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
