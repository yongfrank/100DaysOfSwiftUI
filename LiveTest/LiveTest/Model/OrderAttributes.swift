//
//  OrderAttributes.swift
//  LiveTest
//
//  Created by Frank Chu on 9/17/22.
//

import SwiftUI
import ActivityKit

struct OrderAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        var status: Status = .received
    }
    
    var orderNumber: Int
    var orderItems: String
}


enum Status: String, CaseIterable, Codable, Equatable {
    // MARK: String Values Are SFSymbol Images
    case received = "shippingbox.fill"
    case progress = "person.bust"
    case ready = "takeoutbag.and.cup.and.straw.fill"
}
