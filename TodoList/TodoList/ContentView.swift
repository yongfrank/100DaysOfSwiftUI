//
//  ContentView.swift
//  TodoList
//
//  Created by Frank Chu on 11/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTodo = ""
    @State private var todos: [Item] = []
    
    @State private var showingSheet = false
    @State private var showingString = ""
    
    let storedKey: String = "todoKey"
    
    var body: some View {
        NavigationStack {
            Group {
                enterTodosView
                List {
                    ForEach(todos) { todo in
                        Text(todo.todo)
                            .onTapGesture {
                                showingSheet.toggle()
                                showingString = todo.todo
                            }
                    }
                    .onDelete(perform: delete)
                }
            }
            .navigationTitle("Todos")
        }
        .sheet(isPresented: $showingSheet, content: {
            TextField("Change Name", text: $showingString)
                .textFieldStyle(.roundedBorder)
                .padding()
        })
        .onAppear {
            load(key: storedKey)
        }
    }
    
//    var sheetView: some View {
//
//    }
    
    /// TextField and Add Button
    var enterTodosView: some View {
        HStack {
            TextField("New todo...", text: $currentTodo)
                .textFieldStyle(.roundedBorder)
                .submitLabel(.done)
                .onSubmit {
                    submitNewTodo()
                }
            Button {
                submitNewTodo()
            } label: {
                Image(systemName: "text.badge.plus")
            }
            .buttonStyle(.borderedProminent)
            .disabled(currentTodo == "" ? true : false)
        }
        /// `@inlinable public func padding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some View`
        .padding(
            [
                .horizontal,
                .bottom
            ]
        )
    }
    
    /// Save Data in UserDefaults
    /// - Parameters:
    ///   - toBeSaved: Item array
    ///   - forKey: key of item
    private func save(from toBeSaved: [Item], forKey: String) {
        
        /// ```
        /// if let encoded = try? JSONEncoder().encode(items) {
        ///     UserDefaults.standard.set(encoded, forKey: "Items")
        /// }
        /// Userdefaults.standard.set(try? JSONEncoder().encode(items), forKey: "Items")
        /// ```
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(toBeSaved),
            forKey: forKey
        )
    }
    
    /// When you want to add todo to array, execute the function.
    private func submitNewTodo() {
        todos = FunctionsOfButton.shared.addToTodoArray(
            from: todos,
            add: .init(todo: currentTodo)
        )
        self.save(from: todos, forKey: storedKey)
        self.load(key: storedKey)
        currentTodo = ""
    }
    
    ///
    /// ```
    /// if let savedItems = UserDefaults.standard.data(forKey: "Items") {
    ///     if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
    ///         items = decodedItems
    ///         return
    ///     }
    /// }
    /// ```
    private func load(key: String) {
        if let todosData = UserDefaults.standard.value(forKey: key) as? Data {
            if let todosList = try? PropertyListDecoder().decode(Array<Item>.self, from: todosData) {
                self.todos = todosList
            }
        }
    }
    
    private func delete(at offset: IndexSet) {
        todos.remove(atOffsets: offset)
        save(from: todos, forKey: storedKey)
    }
}

struct FunctionsOfButton {
    static let shared: FunctionsOfButton = .init()
    func addToTodoArray(from todos: [Item], add newTodo: Item) -> [Item] {
        var newTodos = todos
        newTodos.append(newTodo)
        return newTodos
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
