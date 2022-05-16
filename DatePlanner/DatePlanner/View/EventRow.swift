//
//  EventRow.swift
//  DatePlanner
//
//  Created by Frank Chu on 4/10/22.
//

import SwiftUI

struct EventRow: View {
    let eventInEventRow: Event
    
    var body: some View {
        HStack {
            Image(systemName: eventInEventRow.symbol)
                .sfSymbolStyling()
                .foregroundColor(eventInEventRow.color)
                
            VStack(alignment: .leading, spacing: 5) {
                Text(eventInEventRow.title)
                    .fontWeight(.bold)
                
                Text(eventInEventRow.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption2)
                    .foregroundColor(.secondary)
                
            }
            if eventInEventRow.isComplete {
                Spacer()
                Image(systemName: "checkmark")
                    .foregroundColor(.secondary)
            }
        }
        .badge(eventInEventRow.remainingTaskCount)
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRow(eventInEventRow: Event.example)
    }
}
