//
//  EventSymbols.swift
//  DatePlanner
//
//  Created by Frank Chu on 4/10/22.
//

import Foundation

struct EventSymbols {
    static func randomNameByF() -> String {
        if let random = symbolNamesByF.randomElement() {
            return random
        } else {
            return ""
        }
    }
    
//    static func randomNames(_ number: Int) -> [String] {
//        var names: [String] = []
//        for _ in 0..<number {
//            names.append(randomNameByF())
//        }
//        return names
//    }
    
    
    static var symbolNamesByF: [String] = [
        "house.fill",
        "ticket.fill",
        "gamecontroller.fill",
    ]
}
