//
//  DataController.swift
//  Bookworm
//
//  Created by Frank Chu on 4/5/22.
//

import CoreData
import Foundation

class DataControllerCreatedByFrank: ObservableObject {
    let containerCreatedByFrank: NSPersistentContainer = NSPersistentContainer(name: "Bookworm")
    
    init() {
        containerCreatedByFrank.loadPersistentStores { descriptionByFrank, errorByFrank in
            if let errorByFrank = errorByFrank {
                print("Core Data failed to load: \(errorByFrank.localizedDescription)")
            }
        }
    }
}
