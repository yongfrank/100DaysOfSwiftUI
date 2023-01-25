//: [Previous](@previous)

import Foundation

class Singer {
    func playSong() {
        print("Shake it off!")
    }
}

func sing() -> ((String) -> Void) {
    let taylor = Singer()

//    let singing: () -> () = { [weak taylor] in
//        guard let taylor = taylor else {
//            print("No taylor")
//            return
//        }
//        taylor.playSong()
//        return
//    }
    
    let singing: (String) -> () = { [taylor] message in
        print(message)
        taylor.playSong()
        return
    }
    
    return singing
}

sing()("Taylor is going to sing")

print("\n================\n")

func square(_ number: inout Int) {
    number *= number
}
var number = 3
square(&number)
print(number)

class Mankind {
    var name: String
    weak var spouse: Mankind?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(self.name) is dying")
    }
}

var boy: Mankind? = Mankind(name: "BOY")
var girl: Mankind? = Mankind(name: "GIRL")

class Order {
    unowned var purchaser: Mankind
    
    init(purchaser: Mankind) {
        self.purchaser = purchaser
    }
    
    deinit {
        print("\(self.purchaser)'s order has benn deleted")
    }
}

let boysOrder = Order(purchaser: boy!)
//boy = nil
//print(boysOrder.purchaser)

protocol Work: AnyObject {
    var finished: Bool { get }
}

class EngineersWork: Work {
    var finished: Bool
    
    init(finished: Bool) {
        self.finished = finished
    }
}

class Engineer {
    var task: Work?
}

let frank = Engineer()
frank.task = EngineersWork.init(finished: true)

print("==================================")

class House {
    var ownerDetails: (() -> Void)?
    
    func printDetails() {
        print("This is a great house.")
    }
    
    deinit {
        print("This house is going to be demolished")
    }
}

class Owner {
    var houseDetails: (() -> Void)?
    
    func printDetails() {
        print("I own a house.")
    }
    
    deinit {
        print("I'm dying.")
    }
}

print("Creating house and owner")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = { [weak owner] in
        owner?.printDetails()
    }
    owner.houseDetails = { [weak house] in
        house?.printDetails()
    }
    
    // We don’t need a catch block here, but using do ensures they will be destroyed as soon as the } is reached:
}

print("Done")


//: [Next](@next)
