//: [Previous](@previous)

import Foundation
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

private var _logger = ConsoleLogged(wrappedValue: 3)
var logger: Int {
    get { _logger.wrappedValue }
    set { _logger.wrappedValue = newValue }
}

_logger.wrappedValue += 5
print(_logger.wrappedValue)

let string = """
123
4556
"""

print(string)
//: [Next](@next)
