//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

import SwiftUI


let cfstr = NSMutableString(string: "This 😄 is my string 😄") as CFMutableString
func transformUnicode(_ input : String) -> String {
    let cfstr = NSMutableString(string: input) as CFMutableString
    var range = CFRangeMake(0, CFStringGetLength(cfstr))
    CFStringTransform(cfstr, &range, kCFStringTransformToUnicodeName, Bool(0))
    let newStr = "\(cfstr)"
    return newStr.stringByReplacingOccurrencesOfString("\\N", withString:"")
}

transformUnicode("This 😄 is my string 😄")


//: [Next](@next)
