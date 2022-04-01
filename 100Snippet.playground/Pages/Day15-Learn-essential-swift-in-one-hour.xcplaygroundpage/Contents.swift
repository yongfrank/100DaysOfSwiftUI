//: [Previous](@previous)

import Foundation

var name = "Ted"
name = "Rebecca"

let actor = "Tom Cruise"
let movie = """
A day in
my mind

"""

print(movie.count)

struct Employee {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 2 {
        didSet {
            print("you have set new taken \(vacationTaken)")
        }
    }

    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }
        
        set {
            vacationTaken = vacationAllocated - newValue
        }
        
    }
    
}

var Taylor = Employee(name: "Taylor Swift")
Taylor.vacationRemaining = 1
print("Taylor has \(Taylor.vacationRemaining) days remaining")
print(Taylor.vacationAllocated)
print(Taylor.vacationTaken)

Taylor.vacationTaken = 5
Taylor.vacationRemaining
//: [Next](@next)
