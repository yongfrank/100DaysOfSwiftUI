//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

var secondsValue = 75
func reset(seconds: inout Int) {
    seconds = 0
}
reset(seconds: &secondsValue)

print("Seconds is now \(secondsValue)")


/*:
 
 > Question
 */


let hahaTestNames = ["Terry Jones", "John Terry", "Terry Crews", "Terry Farrell", "Samuel Terry"]

let filteredTerry = hahaTestNames.filter{ $0.hasPrefix("Terry") }
print(filteredTerry)



/*:
 
 > I don't know how to resolve it
 */
//: [Next](@next)
