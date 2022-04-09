//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"


func square(number: Int) -> Int {
    return number * number
}
let result = square(number: 8)
print(result)



func greet(_ person: String = "Wooooooooo") {
    print("Hello, \(person)!")
}

greet("Hello, Frank!")
greet()

print(greeting, greeting)


func sayHello(to names: String...) {
    for name in names {
        print("Hello, \(name)!")

    }
}

sayHello(to: "Frank", "Amber", "Paul")

enum PasswordError: Error {
    case obvious, good
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    } else if password.count > 10 {
        throw PasswordError.good
    }

    return true
}

do {
    if try checkPassword("1000000000") {
        print("OK")
    }
    print("Not if OK!")
} catch {
    
    print("NO!!!")
}

func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)






//: [Next](@next)
