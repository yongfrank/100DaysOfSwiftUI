//
//  Candy+CoreDataProperties.swift
//  CoreDataLearning
//
//  Created by Frank Chu on 3/11/23.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }

}

extension Candy : Identifiable {

}
