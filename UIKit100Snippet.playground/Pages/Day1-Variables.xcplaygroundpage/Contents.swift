//: [Previous](@previous)

//: Playground - noun: aplace where people can play

/*:
 
 **This is Frank's Test Page**
 
 > Let me know your idea?
 
 ![estonia flag](Estonia.png)
 
 */

import Foundation

import SwiftUI

var str = "Hello, playground"
str = "I'm Frank"

var str1 = """
This goes
over multiple
lines
"""

print(str1)
var str2 = """
This goes \
over multiple \
lines
"""
print(str2)

var coleridge = """
Water, water, everywhere
and not a drop to drink
"""

print(coleridge)

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut

        if let result = formatter.string(from: value as NSNumber) {
            appendLiteral(result)
        }
    }
    
    mutating func appendInterpolation(_ value: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .full

        let dateString = formatter.string(from: value)
        appendLiteral(dateString)
    }
}

print("Today's date is \(199).")

//: [Next](@next)
