//
//  Person.swift
//  Project10NameToFaces
//
//  Created by Frank Chu on 3/3/23.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
