//: [Previous](@previous)
/*:
 Day 8
 */

/*:
 This part is about Function Error
 */


import Foundation

var greeting = "Hello, playground"

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)
characters.removeAll()
print(characters.count)

func takePicture(withFlash flash: Bool = true) {
    if flash {
        print("I'm taking a photo with flash")
    } else {
        print("I'm taking a photo")
    }
}

takePicture()
func fireArrow(skillLevel: Int = 1) {
    switch skillLevel {
    case 1...3:
        print("You missed the target.")
    case 4...7:
        print("You hit the target.")
    case 8...10:
        print("Great shot!")
    default:
        print("IDK")
    }
}

fireArrow()
let string = "12345678"

enum PasswordError: Error {
    case short, obvious
}
func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }

    if password == "12345" {
        throw PasswordError.obvious
    }

    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error.")
}

enum BuildingError: Error {
    case tooHigh
    case tooLow
}
func constructBuilding(height: Int) throws {
    if height < 10 {
        throw BuildingError.tooLow
    } else if height > 500 {
        throw BuildingError.tooHigh
    }
    print("Perfect - let's get building!")
}

enum ChargeError: Error {
    case noCable, noPower
}
func chargePhone(atHome: Bool) throws {
    if atHome {
        print("Phone is charging...")
    } else {
        throw ChargeError.noPower
    }
}
/*:
 Check Point 2
 */

enum sqrtError: Error {
    case noSqrtNumber, outOfBounds
}

func calculateSquareRoot(_ number: Int) throws -> Int{
    if number < 1 || number > 10000 {
        throw sqrtError.outOfBounds
    }
    for i in 1...100 {
        if i * i == number && i != number {
            return i
        }
    }
    throw sqrtError.noSqrtNumber
}
print("\n")
let calculateNumber = 100000

do {
    let result = try calculateSquareRoot(calculateNumber)
    print("The square root of \(calculateNumber) is \(result)")
} catch sqrtError.noSqrtNumber {
    print("There is no integer square root of number \(calculateNumber)")
} catch sqrtError.outOfBounds {
    print("It's out of bounds, please enter integer between 1 to 10000")
}


// CheckPoint 2
//: [Next](@next)
