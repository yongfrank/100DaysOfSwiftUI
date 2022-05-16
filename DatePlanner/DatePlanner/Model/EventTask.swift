//
//  EventTask.swift
//  DatePlanner
//
//  Created by Frank Chu on 4/10/22.
//

import Foundation

struct EventTask: Identifiable, Hashable {
    var id = UUID()
    var text: String
    var isCompleted = false
    var isNew = false
}
