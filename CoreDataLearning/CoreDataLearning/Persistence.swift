//
//  Persistence.swift
//  CoreDataLearning
//
//  Created by Frank Chu on 3/9/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        
        var candyName = ["Mars", "KitKat", "Twix", "Toblerone"]
        let countryName: [String: String] = ["UK": "United Kingdom", "CH": "Switzerland", "US": "United State"]
        
        for _ in 0..<4 {
            let candy = Candy(context: viewContext)
            candyName = candyName.shuffled()
            candy.name = candyName.popLast()!
            candy.origin = Country(context: viewContext)
            let country = countryName.randomElement()!
            candy.origin?.shortName = country.key
            candy.origin?.fullName = country.value
        }
        
//        let candy1 = Candy(context: viewContext)
//        candy1.name = "Mars"
//        candy1.origin = Country(context: viewContext)
//        candy1.origin?.shortName = "UK"
//        candy1.origin?.fullName = "United Kingdom"
//
//        let candy2 = Candy(context: viewContext)
//        candy2.name = "KitKat"
//        candy2.origin = Country(context: viewContext)
//        candy2.origin?.shortName = "UK"
//        candy2.origin?.fullName = "United Kingdom"
//
//        let candy3 = Candy(context: viewContext)
//        candy3.name = "Twix"
//        candy3.origin = Country(context: viewContext)
//        candy3.origin?.shortName = "UK"
//        candy3.origin?.fullName = "United Kingdom"
//
//        let candy4 = Candy(context: viewContext)
//        candy4.name = "Toblerone"
//        candy4.origin = Country(context: viewContext)
//        candy4.origin?.shortName = "CH"
//        candy4.origin?.fullName = "Switzerland"
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    // which is the Core Data type responsible for loading a data model and giving us access to the data inside
    // 这是负责加载数据模型并允许我们访问内部数据的核心数据类型
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        self.container = NSPersistentContainer(name: "CoreDataLearning")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        self.container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        self.container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
