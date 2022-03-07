//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

struct Employee {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }

        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

var archer = Employee(name: "Sterling Archer", vacationAllocated: 14)
archer.vacationTaken += 4
archer.vacationAllocated = 100

print(archer.vacationAllocated)
print(archer.vacationTaken)
print(archer.vacationRemaining)

struct City {
    var population: Int
    var description: String {
        if population < 100_000 {
            return "This is a small city."
        } else if population < 1_000_000 {
            return "This is a medium-sized city."
        } else {
            return "This is a large city."
        }
    }
}
let tokyo = City(population: 12_000_000)
print(tokyo.description)

struct Dog {
    var breed: String
    var cuteness: Int
    var rating: String {
        if cuteness < 3 {
            print("That's a cute dog!")
        } else if cuteness < 7 {
            print("That's a really cute dog!")
        } else {
            print("That a super cute dog!")
        }
        return "This is rating" // It's important.
    }
}
let luna = Dog(breed: "Samoyed", cuteness: 11)
print(luna.rating)

struct Sunglasses {
    var protectionLevel: Int
    var visionTest: String {
        if protectionLevel < 3 {
            return "These aren't very dark"
        } else if protectionLevel < 6 {
            return "These are just right"
        } else if protectionLevel < 10 {
            return "Who turned the lights out?"
        }
        return "Grater than 10"
    }
}

let oakley = Sunglasses(protectionLevel: 5)
print(oakley.visionTest)


struct Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var game = Game()
game.score += 10
game.score -= 3
game.score += 1
game.score += 100

struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }

        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")

struct Player {
    let name: String
    let number: Int

    init(name: String) {
        self.name = name
        number = Int.random(in: 1...99)
    }
}

let player = Player(name: "Megan R")
print(player.number)

struct Employee2 {
    var name: String
    var yearsActive = 0

    init(yearsActive: Int) {
        self.name = "Anonymous"
        self.yearsActive = yearsActive
        print("Creating an anonymous employee…")
    }
}

let amy = Employee2(yearsActive: 10)
print(amy.name)
print(amy.yearsActive)

struct Employee3 {
    var name: String
    var yearsActive = 0
}

extension Employee3 {
    init() {
        self.name = "Anonymous"
        print("Creating an anonymous employee…")
    }
}

// creating a named employee now works
let roslin = Employee3(name: "Laura Roslin")
print(roslin.name)
// as does creating an anonymous employee
let anon = Employee3()



//: [Next](@next)
