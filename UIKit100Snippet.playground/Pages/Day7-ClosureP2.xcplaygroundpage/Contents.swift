//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

let closureTemp = { (temp: String) in
    print("\(temp)")
}

func travel(someThingToDo: (String) -> Void) {
    //print("HI")
    someThingToDo("London")
}

travel(someThingToDo: closureTemp)


travel { (temp: String) in
    print("I'm going to \(temp).")
}

//: >[在接受参数时使用闭包作为参数](https://www.hackingwithswift.com/sixty/6/6/using-closures-as-parameters-when-they-accept-parameters) https://www.hackingwithswift.com/sixty/6/6/using-closures-as-parameters-when-they-accept-parameters

let changeSpeed = { (speed: Int) in
    print("Changing speed to \(speed)kph")
}
func buildCar(name: String, engine: (Int) -> Void) {
    // build the car
    print("I will build the car")
}

buildCar(name: "BMW", engine: changeSpeed)

//:>wooo

func fetchData(then parse: (String) -> Void) {
    let data = "Success!"
    parse(data)
}
fetchData { (data: String) in
    print("Data received: \(data)")
}

func makePizza(addToppings: (Int) -> Void) {
    print("The dough is ready.")
    print("The base is flat.")
    addToppings(3)
}
makePizza { (toppingCount: Int) in
    let toppings = ["ham", "salami", "onions", "peppers"]
    for i in 0..<toppingCount {
        let topping = toppings[i]
        print("I'm adding \(topping)")
    }
}

func getMeasurement(handler: (Double) -> Void) {
    let measurement = 32.2
    handler(measurement)
}
getMeasurement { (measurement: Double) in
    print("It measures \(measurement).")
}

//: >[在返回值时使用闭包作为参数](https://www.hackingwithswift.com/sixty/6/7/using-closures-as-parameters-when-they-return-values) https://www.hackingwithswift.com/sixty/6/7/using-closures-as-parameters-when-they-return-values
func reduce(_ values: [Int], using closure: (Int, Int) -> Int) -> Int {
    // start with a total equal to the first value
    var current = values[0]

    // loop over all the values in the array, counting from index 1 onwards
    for value in values[1...] {
        // call our closure with the current value and the array element, assigning its result to our current value
        current = closure(current, value)
    }

    // send back the final current value
    return current
}

let arr = Array(1...5)

//let sum = reduce(arr) { (runningTotal: Int, next: Int) in
//    runningTotal + next
//}
let sum = reduce(arr, using: +)

print(sum)

func reduceByF(_ values: [Int]) -> Int {
    // start with a total equal to the first value
    var current = values[0]

    // loop over all the values in the array, counting from index 1 onwards
    for value in values[1...] {
        // call our closure with the current value and the array element, assigning its result to our current value
        current += value
    }

    // send back the final current value
    return current
}

reduceByF(arr)

func goShopping(for item: String, decisionHandler: (String) -> Bool) {
    print("I'm going to buy \(item)")
    if decisionHandler("shoes") == true {
        print("Great! I bought them.")
    } else {
        print("Maybe next time...")
    }
}
goShopping(for: "shoes") { item in
    if item == "shoes" {
        return false
    } else {
        return true
    }
}


print("=================================")
func travelByF(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
}

travelByF {
    return "I'm going to \($0) someday!"
}


//: [Next](@next)
