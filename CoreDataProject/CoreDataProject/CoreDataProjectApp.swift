//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Frank Chu on 4/7/22.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    
    @StateObject private var dataControllerByF = DataControllerInCoreData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataControllerByF.containerByF.viewContext)
        }
    }
}
