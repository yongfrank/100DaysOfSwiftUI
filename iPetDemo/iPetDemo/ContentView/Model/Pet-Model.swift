//
//  Pet-Model.swift
//  iPetDemo
//
//  Created by Frank Chu on 6/12/22.
//

import Foundation

struct Pet: Codable {
    var name: String
    var birthday = Date()
    var lastMeal: Date
    var lastDrink: Date
    
    var isHappy: Bool {
        hunger == "Hungry" || thirsty == "Thirsty" ? false : true
    }

    var age: Int {
        calTime(date: birthday)
    }
    
    var hunger: String {
        let timeSince = calTime(date: lastMeal)
        var string = "Hungry"
        
        switch timeSince {
        case 0..<30: string = "Satisfied"
        case 30..<60: string = "Getting hungry"
        case 60...: string = "Hungry"
        default: string = "IDK"
        }
        return string
    }
    
    var thirsty: String {
        let timeSince = calTime(date: lastDrink)
        var string = "Thirsty"
        
        switch timeSince {
        case 0..<30: string = "Satisfied"
        case 30..<60: string = "Getting thirsty"
        case 60...: string = "Thirsty"
        default: string = "IDK"
        }
        
        return string
    }
    
    
}
