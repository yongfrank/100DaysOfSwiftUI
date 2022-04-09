//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

// Tuple Day 7 return multiple values https://www.hackingwithswift.com/100/swiftui/7

let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

favoriteIceCream["Paul"]

let prices = ["Milk": 1, "Pepsi": 2]
let first = prices["0", default: 520]

var favoriteColors = Dictionary<String, String>()

var mountainHeights = [String: Int]()

enum Result {
    case success
    case failure
}
print(Result.self)

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}
let talking = Activity.talking(topic: "football")
print(talking)

enum Planet {
    case mercury
    case venus
    case earth
    case mars
}
//let happy = Planet(rawValue: 2)
//print(happy ?? "Heihei")

//: [Next](@next)
