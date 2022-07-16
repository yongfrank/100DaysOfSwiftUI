//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"
enum FrankHTTPResponse {
    case ok
    case ffnotfound
}

let res = FrankHTTPResponse.ok
if res == .ffnotfound {
    print("HI")
} else {
    print("ok")
}
print("heloo")
//: [Next](@next)
