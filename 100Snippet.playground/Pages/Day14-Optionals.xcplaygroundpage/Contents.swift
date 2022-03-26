//: [Previous](@previous)

let opposites = [
    "Mario": "Wario",
    "Luigi": "Waluigi"
]

let peachOpposite = opposites["Peach"]

var username: String? = nil

if let unwrappedName = username {
    print("We got a user: \(unwrappedName)")
} else {
    print("The optional was empty.")
}

func square(number: Int) -> Int {
    number * number
}

var number: Int? = nil

if let unwrapperdNumber = number {
    print(square(number: unwrapperdNumber))
}


if let _: Bool? = nil {
    print("I know you like it!")
} else {
    print("I'm not sure")
}

var favoriteMovie: String? = nil
favoriteMovie = "The Life of Brian"
if let movie = favoriteMovie {
    print("Your favorite movie is \(movie).")
} else {
    print("You don't have a favorite movie.")
}

var myVar: Int? = 3

let names = ["Vincent": "van Gogh", "Pablo": "Picasso", "Claude": "Monet"]
let surnameLetter = names["Vincent"]?.first?.uppercased()
//let surnameLetter = names["Vincent"]?.first?.uppercased() ?? "?"

enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

let user = (try? getUser(id: 23)) ?? "Anoymous"

print("User: \(user)")

//: Check Point 9

func getAndReturnANumber(num: Int) -> Int {
    return num
}
//let returnNumber = (try? getAndReturnANumber(num: 0)) ?? 10

func mindBlown(_ input: [Int]?) -> Int {
    return input?.randomElement() ?? Int.random(in: 1...100)
}
print(mindBlown(nil))

let array: [Int]? = [30, 50, 40]
let mindBlow = array?.randomElement() ?? Int.random(in: 1...100)
print(mindBlow)


//: [Next](@next)
