//
//  CoreDataStack.swift
//  Fetch Contacts
//
//  Created by Frank Chu on 11/30/22.
//

import Foundation
import CoreData

class CoreDataStack: ObservableObject {
    private let persistentContainer: NSPersistentContainer
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
//    static var preview: CoreDataStack = {
//        let result = CoreDataStack(modelName: "Preview")
//        
//    }()
    
    init(modelName: String) {
        // 'self' used in method call 'returnContainer' before all stored properties are initialized
        persistentContainer = {
            let container = NSPersistentContainer(name: modelName)
            container.loadPersistentStores { _, error in
                if let error = error {
                    print(error)
                }
            }
            return container
        }()
    }
    
    func save() {
        guard managedObjectContext.hasChanges else { return }
        do {
            try self.managedObjectContext.save()
        } catch {
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func insertContact(firstName: String, lastName: String, phoneNumber: String) {
        let contact = Contact(context: managedObjectContext)
        contact.firstName = firstName
        contact.lastName = lastName
        contact.phoneNumber = phoneNumber
    }
}

func addContacts(to coreDataStack: CoreDataStack) {
    guard UserDefaults.standard.bool(forKey: "alreadyRun") == false else {
        return
    }
    
    UserDefaults.standard.set(true, forKey: "alreadyRun")
    
    [
        ("Daenerys", lastName: "Targaryen", "010"),
        ("Bran", lastName: "Y", "020"),
        ("Appleseed", lastName: "Stark", "020")
    ]
        .forEach { (firstName, lastName, phoneNumber) in
            coreDataStack.insertContact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        }
}
