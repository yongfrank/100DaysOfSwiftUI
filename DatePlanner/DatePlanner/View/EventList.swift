//
//  EventList.swift
//  DatePlanner
//
//  Created by Frank Chu on 4/10/22.
//

import SwiftUI

struct EventList: View {
    @EnvironmentObject var eventData: EventData
    
    
    
    var body: some View {
        List {
            ForEach(Period.allCases) { period in
                if !eventData.sortedEvents(period: period).isEmpty {
                    Section(content: {
                        ForEach(eventData.sortedEvents(period: period)) { $event in
                            NavigationLink {
                                Text("Hello, world!")
                            } label: {
                                EventRow(eventInEventRow: event)
                            }

                        }
                    }, header: {
                        Text(period.name)
                    })
                }
            }
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList().environmentObject(EventData())
    }
}
