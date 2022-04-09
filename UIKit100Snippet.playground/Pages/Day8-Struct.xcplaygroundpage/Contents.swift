//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"


struct Sport {
    var name: String
    var isOlympicSport: Bool

    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

let chessBoxing = Sport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

struct Pokemon {
    var name: String
    func attack(with attackType: String) {
        print("\(name) uses \(attackType)!")
    }
}

let Pika = Pokemon(name: "Pikachu")

Pika.attack(with: "Thunder")

extension String {
    func printByFrank() {
        print(self)
    }
}

let apple = "I've go to Apple Store today"
apple.printByFrank()

let stringCount = "I love ❤️"
stringCount.count
stringCount.isEmpty
stringCount.sorted()

var examScores = [100, 95, 92]
examScores.insert(10, at: 0)




//: [Next](@next)
