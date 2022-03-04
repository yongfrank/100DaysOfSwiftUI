//: [Previous](@previous)

import Foundation
import Darwin

var greeting = "Hello, playground"

func areLettersIndentical(string1: String, string2: String) -> Bool {
    let string1 = string1.sorted()
    let string2 = string2.sorted()
    return string2 == string1
}

print(areLettersIndentical(string1: "acd", string2: "adc"))

func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

pythagoras(a: 3, b: 4)

func rollDice(sides: Int, count: Int) -> [Int] {
    // Start with an empty array
    var rolls = [Int]()

    // Roll as many dice as needed
    for _ in 1...count {
        // Add each result to our array
        let roll = Int.random(in: 1...sides)
        rolls.append(roll)
    }

    // Send back all the rolls
    return rolls
}

let rolls = rollDice(sides: 6, count: 4)
print(rolls)

func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLD"
let result = isUppercase(string)

func printTimesTables(number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5)

func estimateCost(unit: Int) -> Int {
    unit < 10 ? 20 : 50
}

let (res) = estimateCost(unit: 111)
print(res)

func formatLength(length apple: Int) {
    print("That measures \(apple)cm.")
}
formatLength(length: 95)

func evaluateJavaScript(_ input: String) {
    print("Yup, that's JavaScript alright.")
}

evaluateJavaScript("Hi")



//: [Next](@next)
