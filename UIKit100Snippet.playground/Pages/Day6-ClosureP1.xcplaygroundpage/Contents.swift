//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"


let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car with return"
}
let message = drivingWithReturn("London")
print(message)







let driving = { (by: Int, wowo: Int) in
    print("I'm driving in my \(by) car \(wowo)")
}



func travel(actionByFrank: (Int, Int) -> Void, apple: Int = 100) -> String {
    print("+++++++++++++++++++++++")
    actionByFrank(10, 5)
    return "So complicated, I have \(apple)"
}

let temp = travel(actionByFrank: driving, apple: 300)
print(temp)


print("+++++++++++++++++++++++")






func greet(person: String = "Wooooooooo") {
    print("Hello, \(person)!")
}
greet(person: "Taylor")






//: [Next](@next)
