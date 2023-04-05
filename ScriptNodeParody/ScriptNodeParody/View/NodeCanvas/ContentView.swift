//
//  ContentView.swift
//  ScriptNodeParody
//
//  Created by Frank Chu on 3/25/23.
//

import SwiftUI

@propertyWrapper
struct ConsoleLogged<Value> {
    private var value: Value
    
    var wrappedValue: Value {
        get { value }
        set {
            value = newValue
            print("new value is \(newValue)")
        }
    }
    
    init(wrappedValue: Value) {
        self.value = wrappedValue
    }
}

struct ContentView: View {
    private var _logger = ConsoleLogged(wrappedValue: 3)
    var logger: Int {
        get { _logger.wrappedValue }
        set { _logger.wrappedValue = newValue }
    }
//    @Logger var a
    
    @ConsoleLogged var newLogger = 3
    @State var a = 1
    @State(wrappedValue: 2) var b
    var body: some View {
        VStack {
            Text("\(a)")
            Text("\(b)")
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear(perform: {
            print($a)
        })
        .padding()
    }
}

//@propertyWrapper
//struct Logger {
//    private var value: String
//
//    var wrappedValue: String {
//        get { value }
//        set {
//            self.value = newValue
//            print("new Value")
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
