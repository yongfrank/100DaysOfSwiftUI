//
//  iExpenseList.swift
//  iExpense
//
//  Created by Frank Chu on 3/15/22.
//
//  There is a bug about data!!!

import SwiftUI

struct iExpenseList: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var personalOfExpense: [ExpenseItem] {
        expenses.items.filter { item in
            item.type == "Personal"
        }
    }
    var buinessOfExpense: [ExpenseItem] {
        expenses.items.filter { item in
            item.type == "Buiness"
        }
    }
    
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Image(systemName: "person")
                        .frame(width: 30, height: 30)
                    
                    Text("Personal")
                        .font(.body.bold())
                }
                
                
                ForEach(personalOfExpense) { item in
                    ExpenseRow(item: item)
                }
                .onDelete(perform: removeItems)
                
                HStack {
                    Image(systemName: "briefcase")
                        .frame(width: 30, height: 30)
                    Text("Buiness")
                        .font(.body.bold())
                }
                
                ForEach(buinessOfExpense) { item in
                    ExpenseRow(item: item)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                HStack {
                    EditButton()
                
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

}

struct iExpenseList_Previews: PreviewProvider {
    static var previews: some View {
        iExpenseList()
    }
}
