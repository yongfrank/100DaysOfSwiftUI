//
//  Country+CoreDataProperties.swift
//  CoreDataLearning
//
//  Created by Frank Chu on 3/11/23.
//
//

import Foundation
import CoreData


extension Country {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }
    
    @NSManaged public var fullName: String?
    @NSManaged public var shortName: String?
    @NSManaged public var candy: NSSet?
    
    public var wrappedShortName: String {
        self.shortName ?? "Unknown Country"
    }
    
    public var wrappedfullName: String {
        self.fullName ?? "Unknown Country"
    }
    
    public var candyArray: [Candy] {
        let set = candy as? Set<Candy> ?? []
        
        return set.sorted { lhs, rhs in
            lhs.wrappedName < rhs.wrappedName
        }
    }
}

// MARK: Generated accessors for candy
extension Country {

    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: Candy)

    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: Candy)

    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: NSSet)

    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: NSSet)

}

extension Country : Identifiable {

}
