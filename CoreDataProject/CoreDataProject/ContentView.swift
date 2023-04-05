//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Frank Chu on 4/7/22.
//

import SwiftUI
import CoreData

struct FilteredView<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        ForEach(fetchRequest, id: \.self) { order in
            self.content(order)
        }
    }
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Order.numberForID, ascending: false)
    ])
    private var orders: FetchedResults<Order>
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(orders) { order in
                        Text("\(order.wrappedTitle) \(order.numberForID)")
                    }
                }
                
                Section {
                    FilteredView(filterKey: "nameForOrder", filterValue: "a") { (order: Order) in
                        Text("\(order.numberForID) 😵 \(order.wrappedTitle)")
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Add") {
                        let number = Int.random(in: 0..<101)
                        let name = ["h", "w", "a"].randomElement()!
                        let newOrder = Order(context: moc)
                        print(name)
                        newOrder.nameForOrder = name
                        newOrder.numberForID = Int16(number)
                        if moc.hasChanges {
                            try? moc.save()
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, DataController.preview.container.viewContext)
    }
}
