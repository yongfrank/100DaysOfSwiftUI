//
//  ContentView.swift
//  CoreDataLearning
//
//  Created by Frank Chu on 3/9/23.
//

import SwiftUI
import CoreData

// Modify the predicate string parameter to be an enum such as .beginsWith, then make that enum get resolved to a string inside the initializer.
enum PredicateOfCandy: CaseIterable {
    case beginsWith, endsWith, contains
    
    var stringValue: String {
        switch self {
        case .beginsWith:
            return "BEGINSWITH"
        case .endsWith:
            return "ENDSWITH"
        case .contains:
            return "CONTAINS"
        }
    }
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<T>
    
    let content: (T) -> Content
    var body: some View {
        ForEach(countries, id: \.self) { country in
            self.content(country)
        }
    }

    init(filterKey: String,
         filterValue: String,
         predicateValue: PredicateOfCandy,
         sortDescriptor: NSSortDescriptor,
         @ViewBuilder content: @escaping (T) -> Content)
    {
        let predicateTest = NSPredicate(format: "candy.name \(predicateValue.stringValue)[c] %@", filterValue)
        print(filterValue)
        _countries = FetchRequest<T>(sortDescriptors: [sortDescriptor], predicate: filterValue == "" ? nil : predicateTest)
        self.content = content
    }
}

struct SettingsForApp {
    var sortKey: String = "shortName"
    var ascending: Bool = true
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    // Retrieving information from Core Data is done using a fetch request
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)
        ],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @FetchRequest(sortDescriptors: [])
    var countryResults: FetchedResults<Country>

    @State private var filterString = ""
    @State private var predicateCase: PredicateOfCandy = .beginsWith
    @State private var settings = SettingsForApp()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("filter", text: $filterString)
                    Picker("Choose", selection: $predicateCase) {
                        ForEach(PredicateOfCandy.allCases, id: \.self) { candy in
                            Text(candy.stringValue)
                        }
                    }
                    Toggle("Ascending", isOn: $settings.ascending)
                }
                FilteredList(filterKey: "", filterValue: filterString, predicateValue: predicateCase, sortDescriptor: NSSortDescriptor(key: settings.sortKey, ascending: settings.ascending)) { (country: Country) in
                    Section(country.wrappedShortName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button("candy") {
                        let candy1 = Candy(context: viewContext)
                        candy1.name = "Mars"
                        candy1.origin = Country(context: viewContext)
                        candy1.origin?.shortName = "UK"
                        candy1.origin?.fullName = "United Kingdom"

                        let candy2 = Candy(context: viewContext)
                        candy2.name = "KitKat"
                        candy2.origin = Country(context: viewContext)
                        candy2.origin?.shortName = "UK"
                        candy2.origin?.fullName = "United Kingdom"

                        let candy3 = Candy(context: viewContext)
                        candy3.name = "Twix"
                        candy3.origin = Country(context: viewContext)
                        candy3.origin?.shortName = "UK"
                        candy3.origin?.fullName = "United Kingdom"

                        let candy4 = Candy(context: viewContext)
                        candy4.name = "Toblerone"
                        candy4.origin = Country(context: viewContext)
                        candy4.origin?.shortName = "CH"
                        candy4.origin?.fullName = "Switzerland"
                        
                        try? viewContext.save()
                    }
                }
            }
//            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet, at country: Country) {
        withAnimation {
            let candyArray = Array(country.candyArray)
            offsets.map { candyArray[$0] }.forEach(viewContext.delete)
            

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
