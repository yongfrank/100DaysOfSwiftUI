//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

var cutGrass = { (currentLength: Double) in
    switch currentLength {
    case 0...1:
        print("That's too short")
    case 1...3:
        print("It's already the right length")
    default:
        print("That's perfect.")
    }
}
cutGrass(1.01)

let callNumber = { (number: Int) -> String in
    return "Calling now..."
}

callNumber(10)

var costToShootMovie = { (location: String) -> Int in
    if location == "UK" {
        return 1_000_000
    } else if location == "US" {
        return 5_000_000
    } else {
        return 500_000
    }
}
print(costToShootMovie("US"))

func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}
func first() {
    print("haha")
}
func second() {
    print("haha")
}
func third() {
    print("haha")
}

doImportantWork {
    print("ha")
} second: {
    print("haha")
} third: {
    print("ahaha")
}

func animate(duration: Double, animations: () -> Void) {
    print("Starting a \(duration) second animation…")
    animations()
}
animate(duration: 3) {
    print("Fade out the image")
}

func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()

    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }

    return numbers
}

let rolls = makeArray(size: 50) {
    Int.random(in: 1...20)
}

print(rolls)

//func generateNumber() -> Int {
//    Int.random(in: 1...20)
//}
//
//let newRolls = makeArray(size: 50, using: generateNumber)
//print(newRolls)

var playWithDog = {
    print("Fetch!")
}
func play(using playType: () -> Void) -> () {
    print("Let's play a game")
    playType()
}
play(using: playWithDog)

// Checkpoint 5
let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

let stringLuckyNumbers = luckyNumbers
    .filter{ !$0.isMultiple(of: 2)}
    .sorted{ $0 < $1}
    .map { "\($0) is a lucky number" }

for stringLuckNumber in stringLuckyNumbers {
    print(stringLuckNumber)
}


//: [Next](@next)
