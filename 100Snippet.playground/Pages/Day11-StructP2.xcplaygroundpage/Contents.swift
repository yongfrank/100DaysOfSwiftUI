//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"
print(greeting)

struct BankAccount {
    var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)

if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}

struct Doctor {
    var name: String
    var location: String
//    private var currentPatient = "No one"
}
let drJones = Doctor(name: "Esther Jones", location: "Bristol")



struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}

print(AppData.version)

struct Employee {
    let username: String
    let password: String

    static let example = Employee(username: "cfederighi", password: "hairforceone")
}
print(Employee.example.password)

struct Entropy {
    private static var entropy = Int.random(in: 1...1000)

    static func getEntropy() -> Int {
        entropy += 1
        return entropy
    }
}
//print(Entropy.entropy)
print(Entropy.getEntropy())


//: Checkpoint 6

struct YourCar {
    private var model: String
    private var numberOfSeats: Int
    private var currentGear: Int

    init(model: String, seats: Int, gear: Int) {
        self.model = model
        numberOfSeats = seats
        currentGear = gear
    }
    
    mutating func gearsChange(change: Int) {
        if (self.currentGear + change > 10) || (self.currentGear + change < 0) {
            print("Change Error")
        } else {
            self.currentGear += change
            print("Now your current gear is \(currentGear)")
        }
    }
}

var maserati = YourCar(model: "Maserati", seats: 2, gear: 3)
maserati.gearsChange(change: -1)
maserati.gearsChange(change: +10)


// Checkpoint 6 ends here
struct School {
    var staffNames: [String]
    private var studentNames: [String]
    init(staff: String...) {
        self.staffNames = staff
        self.studentNames = [String]()
        print(self.studentNames)
    }
}
let royalHigh = School(staff: "Mrs Hughes")
print(royalHigh.staffNames)

//: [Next](@next)
