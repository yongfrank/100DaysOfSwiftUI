//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Frank Chu on 3/15/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
