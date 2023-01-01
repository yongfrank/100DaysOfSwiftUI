//
//  Fetch_ContactsApp.swift
//  Fetch Contacts
//
//  Created by Frank Chu on 11/30/22.
//

import SwiftUI

@main
struct Fetch_ContactsApp: App {
    private let coreDataStack = CoreDataStack(modelName: "ContactsModel")
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
                .onChange(of: scenePhase) { _ in
                    coreDataStack.save()
                }
                .onAppear {
                    addContacts(to: coreDataStack)
                }
                .environmentObject(coreDataStack)
        }
    }
}
