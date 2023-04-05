//
//  Order+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Frank Chu on 3/10/23.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var numberForID: Int16
    @NSManaged public var nameForOrder: String?
    
    public var wrappedTitle: String {
        nameForOrder ?? "UnknownTitle"
    }

}

extension Order : Identifiable {

}
