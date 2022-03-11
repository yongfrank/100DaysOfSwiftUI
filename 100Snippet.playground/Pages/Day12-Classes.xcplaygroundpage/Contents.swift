//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"
class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10


class Employee {
    let hours: Int

    func printSummary() {
        print("I work \(hours) hours a day.")
    }
    
    init(hours: Int) {
        self.hours = hours
    }
}

final class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    
    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.")
    }
    
}

class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
robert.printSummary()
joseph.work()

class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool

    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}


//class User {
//    var username = "Anonymous"
//    func copy() -> User {
//            let user = User()
//            user.username = username
//            return user
//        }
//}
//
//var user1 = User()
//var user2 = user1.copy()
//user2.username = "Taylor"
//
//print(user1.username)
//print(user2.username)
//
//struct UserStruct {
//    var username = "Anoymous"
//}
//
//var userStruct1 = UserStruct()
//var userStruct2 = userStruct1
//userStruct2.username = "Swift"
//print(userStruct1.username)
//print(userStruct2.username)
//
//struct GalacticaCrew {
//    var isCylon = false
//}
//var starbuck = GalacticaCrew()
//var tyrol = starbuck
//tyrol.isCylon = true
//print(starbuck.isCylon)
//print(tyrol.isCylon)

//class User {
//    let id: Int
//
//    init(id: Int) {
//        self.id = id
//        print("User \(id): I'm alive!")
//    }
//
//    deinit {
//        print("User \(id): I'm dead!")
//    }
//}
//for i in 1...3 {
//    let user = User(id: i)
//    print("User \(user.id): I'm in control!")
//    print("i is \(i)")
//}
//class User {
//    var name = "Paul"
//}
//
//let user = User()
//user.name = "Taylor"
//print(user.name)
class User {
    var name = "Paul"
}

var user = User()
user.name = "Taylor"
//user = User()
print(user.name)

class Phasers {
    var energyLevel = 100
    func firePhasers() {
        if energyLevel > 10 {
            print("Firing!")
            energyLevel -= 10
        }
    }
}
var phasers = Phasers()
phasers.firePhasers()

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    var dogSpeak = ""
    func speak() {
        print(dogSpeak)
    }
    init(dogSpeak: String, legs: Int) {
        self.dogSpeak = dogSpeak
        super.init(legs: legs)
    }
}

class Cat: Animal {
    var catSpeak = ""
    func speak() {
        print(catSpeak)
    }
    init(catSpeak: String, legs: Int) {
        self.catSpeak = catSpeak
        super.init(legs: legs)
    }
}

class Corgi: Dog {
    private var corgiSpeak = "Wofofo"
    
    init(legs: Int, corgiSpeak: String) {
        super.init(dogSpeak: corgiSpeak, legs: legs)
    }
    override func speak() {
        print(corgiSpeak)
    }
}


class Poodle: Dog {
    private var poodleSpeak = "wiwiwi"
    
    init(legs: Int, poodleSpeak: String) {
        super.init(dogSpeak: poodleSpeak, legs: legs)
    }
    override func speak() {
        print(poodleSpeak)
    }
}

class Persian: Cat {
    private var persianSpeak = "meomewo"
    private var isTame: Bool
    
    init(legs: Int, persianSpeak: String, isTame: Bool) {
        self.isTame = isTame
        super.init(catSpeak: persianSpeak, legs: legs)
    }
    override func speak() {
        print(persianSpeak)
    }
}

class Lion: Cat {
    var lionSpeak = "Lion Lion"
    private var isTame: Bool
    
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(catSpeak: lionSpeak, legs: legs)
        
    }
    override func speak() {
        print(lionSpeak)
    }
}

var myLion = Lion(legs: 4, isTame: false)
myLion.lionSpeak = "AAAA"
print(myLion.speak())
myLion.speak()

class Happy {
    var saySomething = ""
    func shout() {
        print(saySomething)
    }
    init(saySomething: String) {
        self.saySomething = saySomething
    }
}

var frank = Happy(saySomething: "Today I've learned class")
frank.shout()
//: [Next](@next)
