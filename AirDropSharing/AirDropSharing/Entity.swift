//
//  Entity.swift
//  AirDropSharing
//
//  Created by Frank Chu on 12/29/22.
//

import Foundation

struct PokeImages: Codable, Equatable {
    let small: String
    let large: String
    
    init(small: String, large: String) {
        self.small = small
        self.large = large
    }
    
    var smallImageUrl: URL? {
        return URL(string: self.small)
    }
    
    var largeImageUrl: URL? {
        return URL(string: self.large)
    }
}

struct PokeCard: Codable, Equatable {
    let id: String
    let name: String
    let supertype: String
    let subtypes: [String]
    let types: [String]
    let level: String?
    let hp: String?
    let nationalPokedexNumbers: [Int]
    let images: PokeImages

    init(
        id: String,
        name: String,
        supertype: String,
        subtypes: [String],
        types: [String],
        level: String?,
        hp: String?,
        nationalPokedexNumbers: [Int],
        images: PokeImages
    ) {
        self.id = id
        self.name = name
        self.supertype = supertype
        self.subtypes = subtypes
        self.types = types
        self.level = level
        self.hp = hp
        self.nationalPokedexNumbers = nationalPokedexNumbers
        self.images = images
    }
}

struct PokeCards: Decodable {
    let data: [PokeCard]
}
