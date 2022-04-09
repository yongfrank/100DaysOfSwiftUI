//
//  DataControllerInCoreData.swift
//  CoreDataProject
//
//  Created by Frank Chu on 4/7/22.
//

import Foundation
import CoreData

class DataControllerInCoreData: ObservableObject {
    let containerByF = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        containerByF.loadPersistentStores { descriptionByF, errorByF in
            if let errorByF = errorByF {
                print("Core Data failed to load: \(errorByF.localizedDescription)")
            }
            
        }
    }
    
    
}
