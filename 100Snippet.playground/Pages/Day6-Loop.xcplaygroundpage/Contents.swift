//: [Previous](@previous)

import Foundation
import Darwin

for i in 1...100 {
    if i.isMultiple(of: 3) && !i.isMultiple(of: 5){
        print("Fizz")
    } else if i.isMultiple(of: 5) && !i.isMultiple(of: 3){
        print("Buzz")
    } else if i.isMultiple(of: 3) && i.isMultiple(of: 5) {
        print("FizzBuzz")
    } else {
        print(i)
    }
}
//: [Next](@next)
