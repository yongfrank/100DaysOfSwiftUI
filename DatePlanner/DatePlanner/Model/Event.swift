//
//  Event.swift
//  DatePlanner
//
//  Created by Frank Chu on 4/10/22.
//

import SwiftUI

struct Event: Identifiable, Hashable {
    var id = UUID()
    var symbol: String = EventSymbols.randomNameByF()
    var color: Color = ColorOptions.randomColorByF()
    var title = ""
    var tasks: [EventTask] = [EventTask(text: "")]
    var date = Date()
    
    var remainingTaskCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }
    
    var isComplete: Bool {
        tasks.allSatisfy { $0.isCompleted }
    }
    
    var isPast: Bool {
        date < Date.now
    }
    
    var isWithinSevenDays: Bool {
        !isPast && date < Date.now.sevenDaysOutByF
    }
    
    var isWithinSevenToThirtyDays: Bool {
        !isPast && !isWithinSevenDays && date < Date.now.thirtyDaysOutByF
    }
    
    var isDistant: Bool {
        
        return date >= Date().thirtyDaysOutByF
        
    }
    
    static var example = Event(
        symbol: "case.fill",
        title: "Sayulita Trip",
        tasks: [
            EventTask(text: "Buy plane tickets"),
            EventTask(text: "Get a new bathing suit"),
            EventTask(text: "Find an airbnb"),
        ],
        date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * 1.5)
    )
    
}


// Convenience methods for dates.
extension Date {
    var sevenDaysOutByF: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 7, to: self) ?? self
    }
    
    var thirtyDaysOutByF: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 30, to: self) ?? self
    }
}
