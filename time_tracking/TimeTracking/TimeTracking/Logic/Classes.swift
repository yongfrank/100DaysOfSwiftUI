//
//  Classes.swift
//  TimeTracking
//
//  Created by Frank Chu on 10/22/22.
//

import Foundation
import SwiftUI

class Clock: Equatable, Identifiable {
    static func == (lhs: Clock, rhs: Clock) -> Bool {
        if lhs.id == rhs.id {
            return true
        } else {
            return false
        }
    }
    
    var id: UUID
    var name: String
    var color: Color
    var timeSegments: [TimeSegment] = []
    
    init(id: UUID? = UUID(), name: String, color: Color) {
        if let id = id {
            self.id = id
        } else {
            self.id = UUID()
        }
        self.name = name
        self.color = color
    }
    
    static var EXAMPLECLOCK: Clock = .init(name: "Work", color: .blue)
}

class TimeSegment: Identifiable {
    var id: UUID
    var startTime: Date {
        willSet {
            print(self.startTime)
        }
    }
    var endTime: Date? = nil
    var assocClock: UUID
    
    init(id: UUID? = UUID(), from startTime: Date, to endTime: Date? = nil, assocClock: UUID) {
        if let id = id {
            self.id = id
        } else {
            self.id = UUID()
        }
        
        self.startTime = startTime
        self.endTime = endTime
        self.assocClock = assocClock
    }
    
    func elapsedTime(refTime: Date) -> Int {
        /// ```
        /// public func dateComponents(
        ///     _ components: Set<Calendar.Component>,
        ///     from date: Date,
        ///     to end: Date
        /// ) -> DateComponents
        /// ```
        /// Returns the difference between two dates.
        let componentDif: DateComponents = Calendar.current.dateComponents(
            [
                Calendar.Component.day,
                Calendar.Component.hour,
                Calendar.Component.minute,
                Calendar.Component.second
            ],
            from: self.startTime,
            to: self.endTime ?? refTime
        )
        
        let d = (componentDif.day ?? 0) * 60 * 60 * 24
        let h = (componentDif.hour ?? 0) * 60 * 60
        let m = (componentDif.minute ?? 0) * 60
        let s = (componentDif.second ?? 0)
        let elapsedSeconds = (d + h + m + s)
        
        return elapsedSeconds
    }
}

class GlobalEnvironment: ObservableObject {
        
    @Published var clocks: [Clock] = [
        Clock(name: "Work", color: .blue),
        Clock(name: "Home", color: .orange),
        Clock(name: "School", color: .green)
    ]
    
    @Published var activeClock: Clock? = nil
    
    @Published var PublicTimer: Timer = Timer()
    @Published var PublicDate: Date = Date()
    
    func activateClock(clock: Clock) {
        self.activeClock = clock
        let newSeg = TimeSegment(from: Date(), assocClock: clock.id)
        
        if let activeClock = self.activeClock {
            if let thisClockIndex = clocks.firstIndex(where: { $0.id == activeClock.id }) {
                self.clocks[thisClockIndex].timeSegments.append(newSeg)
            }
        }
    }
    
    func inactivateClock() {
        if let activeClock = self.activeClock {
            if let thisClockIndex = self.clocks.firstIndex(where: { $0.id == activeClock.id }) {
                
                // last Segment endtime is not nil, add now time to end.
                if self.clocks[thisClockIndex].timeSegments.last?.endTime != nil {
                    print("error: you're trying to end a segment that already has an ending")
                } else {
                    self.clocks[thisClockIndex].timeSegments.last?.endTime = Date()
                    if let lastSegment = self.clocks[thisClockIndex].timeSegments.last {
                        print("\(clocks[thisClockIndex].name) \(lastSegment.startTime) -> \(lastSegment.endTime ?? Date())")
                    }
                }
            }
        }
        
        self.activeClock = nil
    }
}
