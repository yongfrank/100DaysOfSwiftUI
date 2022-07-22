//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"
var s = "123"

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: 2)])
    }
}
//: [Next](@next)
