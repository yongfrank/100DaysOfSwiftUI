//
//  DataController.swift
//  CoreDataProject
//
//  Created by Frank Chu on 3/9/23.
//

import Foundation
import CoreData

struct DataController {
    static let shared: DataController = DataController()
    
    let container: NSPersistentContainer
    
    static let preview: DataController = {
        let result = DataController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<5 {
            let number = Int.random(in: 0..<101)
            let name = ["h", "w", "a"].randomElement()!
            let newOrder = Order(context: viewContext)
            newOrder.nameForOrder = name
            newOrder.numberForID = Int16(number)
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        
        return result
    }()
    
    init(inMemory: Bool = false) {
        self.container = NSPersistentContainer(name: "CoreDataProject")
        if inMemory {
            self.container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        self.container.loadPersistentStores { description, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        
        self.container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
