//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"
var averageScore = 2.5
while averageScore < 15.0 {
    averageScore += 2.5
    print("The average score is \(averageScore)")
}

repeat {
    print("This is false")
} while false


haah: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("It's a bullseye!")
            break haah
        }
    }
}


for i in 1...15 {
    let square = i * i
    if i == 8 {
        continue
    }
    print("\(i) squared is \(square)")
}




var isAlive = false

while isAlive == true {
    print("I'm alive!")
}

print("I've snuffed it!")
//: [Next](@next)
