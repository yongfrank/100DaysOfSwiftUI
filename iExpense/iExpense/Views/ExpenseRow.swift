//
//  ExpenseRow.swift
//  iExpense
//
//  Created by Frank Chu on 3/15/22.
//
//  There is a bug about data!!!

import SwiftUI

struct ExpenseRow: View {
    var item: ExpenseItem
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
                    .font(.caption)
            }
            Spacer()
            
            VStack(alignment: .trailing) {
                if item.amount < 10 {
                    Text("💰")
                        .font(.caption)
                } else if item.amount < 100 {
                    Text("💰💰")
                        .font(.caption)
                } else {
                    Text("💰💰💰")
                        .font(.caption)
                }
                Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
            }
        }
    }
}

struct ExpenseRow_Previews: PreviewProvider {
    
    static var previews: some View {
        ExpenseRow(item: ExpenseItem(name: "Apple TV", type: "Personal", amount: 149))
            .previewLayout(.fixed(width: 400, height: 80))
    }
}
