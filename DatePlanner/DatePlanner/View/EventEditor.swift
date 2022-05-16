//
//  EventEditor.swift
//  DatePlanner
//
//  Created by Frank Chu on 4/10/22.
//

import SwiftUI

struct EventEditor: View {
    @Binding var eventInEventEditor: Event
    var isNew = false
    
    @EnvironmentObject var eventData: EventData
    @State private var isEditing = false
//    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            EventDetail(eventInEventDetail: $eventInEventEditor, isEditing: isNew ? true : isEditing)
        }
    }
}

struct EventEditor_Previews: PreviewProvider {
    static var previews: some View {
        EventEditor(eventInEventEditor: .constant(Event()))
    }
}
