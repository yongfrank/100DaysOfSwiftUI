//
//  EventData.swift
//  DatePlanner
//
//  Created by Frank Chu on 4/10/22.
//

import SwiftUI

class EventData: ObservableObject {
    @Published var eventsInEventData: [Event] = [
        Event(symbol: "gift.fill",
              color: .red,
              title: "Maya's Birthday",
              tasks: [EventTask(text: "Guava kombucha"),
                      EventTask(text: "Paper cups and plates"),
                      EventTask(text: "Cheese platee"),
                      EventTask(text: "Party poppers"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 30)
             ),
        Event(symbol: "theatermasks.fill",
              color: .yellow,
              title: "Pagliacci",
              tasks: [EventTask(text: "Buy new tux"),
                      EventTask(text: "Get tickets"),
                      EventTask(text: "Pick up Carmen at the airport and bring her to the show"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 4)
              ),
        Event(symbol: "facemask.fill",
              color: .indigo,
              title: "Doctor's Appointment",
              tasks: [EventTask(text: "Bring medical ID"),
                      EventTask(text: "Record heart rate data"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 24 * 4)),
        Event(symbol: "leaf.fill",
              color: .green,
              title: "Camping Trip",
              tasks: [EventTask(text: "Find a sleeping bag"),
                      EventTask(text: "Bug spray"),
                      EventTask(text: "Paper towels"),
                      EventTask(text: "Food for 4 meals"),
                      EventTask(text: "Straw hat"),
                     ],
              date: Date.roundedHoursFromNow(60 * 60 * 36)),
    ]
    
    func deleteEventByF(_ event: Event) {
        eventsInEventData.removeAll() { $0.id == event.id }
    }
    
    func addEventByF(_ event: Event) {
        eventsInEventData.append(event)
    }
    
    func existsEventByF(_ event: Event) -> Bool {
        
        return true
    }
    
    func sortedEvents(period: Period) -> Binding<[Event]> {
        Binding<[Event]>(
            get: {
                self.eventsInEventData
                    .filter {
                        switch period {
                        case .nextSevenDays:
                            return $0.isWithinSevenDays
                        case .nextThirtyDays:
                            return $0.isWithinSevenToThirtyDays
                        case .future:
                            
                            return $0.isDistant
                        case .past:
                            return $0.isPast
                        }
                    }
                    .sorted { $0.date < $1.date }
            },
            set: { eventsInEventData in
                for event in eventsInEventData {
                    if let index = self.eventsInEventData.firstIndex(where: { $0.id == event.id }) {
                        self.eventsInEventData[index] = event
                    }
                }
            }
        )
        
    }
}

enum Period: String, CaseIterable, Identifiable {
    case nextSevenDays = "Next 7 Days"
    case nextThirtyDays = "Next 30 Days"
    case future = "Future"
    case past = "Past"
    
    var id: String { self.rawValue }
    var name: String { self.rawValue }
}

extension Date {
    
    static func roundedHoursFromNow(_ hours: Double) -> Date {
        let exactDate = Date(timeIntervalSinceNow: hours)
        guard let hourRange = Calendar.current.dateInterval(of: .hour, for: exactDate) else {
            return exactDate
        }
        return hourRange.end
    }
}
