//
//  ContentView.swift
//  Fetch Contacts
//
//  Created by Frank Chu on 11/30/22.
//

import SwiftUI

struct ContactView: View {
    let contact: Contact
    
    var body: some View {
        NavigationLink(destination: {
            
        }, label: {
            HStack {
                Text(contact.firstName ?? "-")
                Text(contact.lastName ?? "-")
            }
        })
    }
}
struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Contact.firstName, ascending: true),
            NSSortDescriptor(keyPath: \Contact.lastName, ascending: true)
        ]
//        , predicate: NSPredicate(format: "lastName BEGINSWITH %@", "S")
    ) var contacts: FetchedResults<Contact>
    
    @State private var isAddContactPresented = false
    
    @State private var searchText: String = ""
    var body: some View {
        
        NavigationStack {
//            List(contacts, id: \.self) { contact in
//                ContactView(contact: contact)
//            }
            TextField("Search for", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            FilteredContacts(filterString: searchText)
            .toolbar {
                ToolbarItem {
                    Button(action: { self.isAddContactPresented.toggle() }, label: { Image(systemName: "plus")})
                }
            }
            .navigationTitle("Contacts")
        }
        .searchable(text: $searchText)
        .sheet(isPresented: $isAddContactPresented) {
            AddNewContact(isAddContactPresented: $isAddContactPresented)
        }
    }
}

struct ModifyContact: View {
    @Binding var isAddContactPresented: Bool
    @EnvironmentObject var coreDataStack: CoreDataStack
    @Environment(\.isPresented) var isPresent

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    
//    init(isAddContactPresented: Binding<Bool>, firstName: String = "", lastName: String = "", phoneNumber: String = "") {
//        self.firstName = firstName
//        self.lastName = lastName
//        self.phoneNumber = phoneNumber
//    }
    
    // https://www.hackingwithswift.com/sixty/7/2/computed-properties
    // Computed properties
    private var disabledOfSheet: Bool {
        self.firstName.isEmpty || self.lastName.isEmpty || self.phoneNumber.isEmpty
    }
    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Phone Number", text: $phoneNumber)
                }
                .textFieldStyle(.roundedBorder)
                .padding()
            }
            .toolbar {
                ToolbarItem {
                    Button(action: { self.saveContacts() }, label: { Text("Add Contacts")})
                        .disabled(disabledOfSheet)
                        .interactiveDismissDisabled(disabledOfSheet)
                }
            }
        }
        .onChange(of: isPresent) { _ in
            self.saveContacts()
        }
    }
    
    private func saveContacts() {
        coreDataStack.insertContact(firstName: self.firstName, lastName: self.lastName, phoneNumber: self.phoneNumber)
        self.isAddContactPresented.toggle()
        coreDataStack.save()
    }
}

struct AddNewContact: View {
    @Binding var isAddContactPresented: Bool
    @EnvironmentObject var coreDataStack: CoreDataStack
    @Environment(\.isPresented) var isPresent

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    
//    init(isAddContactPresented: Binding<Bool>, firstName: String = "", lastName: String = "", phoneNumber: String = "") {
//        self.firstName = firstName
//        self.lastName = lastName
//        self.phoneNumber = phoneNumber
//    }
    
    // https://www.hackingwithswift.com/sixty/7/2/computed-properties
    // Computed properties
    private var disabledOfSheet: Bool {
        self.firstName.isEmpty || self.lastName.isEmpty || self.phoneNumber.isEmpty
    }
    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Phone Number", text: $phoneNumber)
                }
                .textFieldStyle(.roundedBorder)
                .padding()
            }
            .toolbar {
                ToolbarItem {
                    Button(action: { self.saveContacts() }, label: { Text("Add Contacts")})
                        .disabled(disabledOfSheet)
                        .interactiveDismissDisabled(disabledOfSheet)
                }
            }
        }
        .onChange(of: isPresent) { _ in
            self.saveContacts()
        }
    }
    
    private func saveContacts() {
        coreDataStack.insertContact(firstName: self.firstName, lastName: self.lastName, phoneNumber: self.phoneNumber)
        self.isAddContactPresented.toggle()
        coreDataStack.save()
    }
}

struct FilteredContacts: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @EnvironmentObject var coreDataStack: CoreDataStack
    let fetchRequest: FetchRequest<Contact>
    
    init(filterString: String) {
        let predicate: NSPredicate? = (
            filterString.isEmpty
            ? nil
            : NSPredicate (
                // Case and Diacritic Insensitive
                // https://stackoverflow.com/questions/41701847/who-can-explain-this-nspredicate-syntax
                format: "lastName CONTAINS[CD] %@ OR firstName CONTAINS[CD] %@",
                filterString, filterString)
        )
        fetchRequest = FetchRequest(
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Contact.firstName, ascending: true),
                NSSortDescriptor(keyPath: \Contact.lastName, ascending: true)
            ],
            predicate: predicate
        )
    }
    
    var body: some View {
        List{
            ForEach(fetchRequest.wrappedValue, id: \.self) {
                ContactView(contact: $0)
            }
            .onDelete(perform: deleteContact)
        }
        .listStyle(.plain)
//        .listStyle(.sidebar)
    }
    
    private func deleteContact(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        managedObjectContext.delete(fetchRequest.wrappedValue[index])
        coreDataStack.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(
//                \.managedObjectContext,
//                 CoreDataStack(modelName: "ContactsModel").managedObjectContext
//            )
//            .environmentObject(CoreDataStack(modelName: "ContactsModel"))
    }
}
