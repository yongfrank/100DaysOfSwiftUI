//
//  main.swift
//  JSONTester
//
//  Created by Frank Chu on 10/3/22.
//

import Foundation

/// Second, we need to define coding keys
/// that describe where data can be found in the hierarchy.
let json = """
[
    {
        "name": {
            "first_name": "Taylor",
            "last_name": "Swift"
        },
        "age": 26
    },
    {
        "name": {
            "first_name": "Frank",
            "last_name": "Chu"
        },
        "age": 20
    }
]
"""

let data = Data(json.utf8)

/// First, create the struct you want to end up with
struct User: Codable {
    var firstName: String
    var lastName: String
    var age: Int
    
    /// As you can see, at the root there's a key
    /// called "name" and another called "age",
    /// "so" we need to add that as our root coding keys.
    enum CodingKeys: String, CodingKey {
        case name, age
    }
    
    /// Inside "name" were two more keys, `"first_name"` and `"last_name"`,
    /// so we're going to create some coding keys for those two.
    enum NameCodingKeys: String, CodingKey {
        case firstName, lastName
    }
    
    /// Now for the hard part: we need to write a custom initializer and
    /// custom encode method for our type.
    init(from decoder: Decoder) throws {
        /// Inside there, the first thing we need to do is
        /// attempt to pull out a container we can read
        /// using the keys of our **CodingKeys** enum
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        /// Once that's done we can attempt to read our age property.
        age = try container.decode(Int.self, forKey: .age)
        
        /// Next we need to dig down one level to read our name data.
        let name = try container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        
        firstName = try name.decode(String.self, forKey: .firstName)
        lastName = try name.decode(String.self, forKey: .lastName)
    }
    
    /// `encode(to:)` is effectively the reverse of the initializer we just write.
    func encode(to encoder: Encoder) throws {
        var containder = encoder.container(keyedBy: CodingKeys.self)
        try containder.encode(age, forKey: .age)
        
        var name = containder.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        try name.encode(firstName, forKey: .firstName)
        try name.encode(lastName, forKey: .lastName)
    }
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase

do {
    let decoded = try decoder.decode([User].self, from: data)
    print(decoded)
} catch {
    print(error)
}
