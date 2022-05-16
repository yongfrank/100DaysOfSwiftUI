//
//  EventDetail.swift
//  DatePlanner
//
//  Created by Frank Chu on 4/10/22.
//

import SwiftUI

struct EventDetail: View {
    @Binding var eventInEventDetail: Event
    
    let isEditing: Bool
    
    @State private var isPickingSymbol = false
    var body: some View {
        List {
            HStack {
                Button {
                    isPickingSymbol.toggle()
                } label: {
                    Image(systemName: eventInEventDetail.symbol)
                        .sfSymbolStyling()
                        .foregroundColor(eventInEventDetail.color)
                        .opacity(isEditing ? 0.3 : 1)
                }
            }
        }
    }
}

struct EventDetail_Previews: PreviewProvider {
    static var previews: some View {
        EventDetail(eventInEventDetail: .constant(Event.example), isEditing: true)
    }
}
