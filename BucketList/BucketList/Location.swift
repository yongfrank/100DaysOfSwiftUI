//
//  Location.swift
//  BucketList
//
//  Created by Frank Chu on 6/9/22.
//

import Foundation
import MapKit


//Codable func ==()
struct Location: Identifiable, Equatable, Codable {
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "StringWhere Queen Elizabeth lives with her dorgis.", latitude: 51.501, longitude: -0.141)
}
