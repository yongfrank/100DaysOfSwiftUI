//
//  Pokemon.swift
//  PokedexSwiftUI
//
//  Created by Frank Chu on 6/11/22.
//

import Foundation

// Codable identifible
struct Pokemon: Decodable, Identifiable {
    var id: Int
    var name: String
    var imageUrl: String
    var type: String
    var description: String
    var height: Int
    var weight: Int
    var attack: Int
    var defense: Int
    var evolutionChain: [EvolutionChain]?
}

struct EvolutionChain: Decodable {
    let id: String?
    let name: String?
}

let urlOfBulbasaur =  "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2F2CF15848-AAF9-49C0-90E4-28DC78F60A78?alt=media&token=15ecd49b-89ff-46d6-be0f-1812c948e334"

let MOCK_POKEMON: [Pokemon] = [
    .init(id: 1,
          name: "Bulbasaur",
          imageUrl: urlOfBulbasaur,
          type: "poison",
          description: "Bulbasaur can be seen napping in bright sunlight. There is a seed on its back. By soaking up the sun’s rays, the seed grows progressively larger.",
          height: 7,
          weight: 69,
          attack: 49,
          defense: 49,
          evolutionChain: nil
         )
//    .init(id: 2, name: "Ivysaur", imageUrl: "1", type: "poison"),
//    .init(id: 3, name: "Venusaur", imageUrl: "1", type: "poison"),
//    .init(id: 4, name: "Charmander", imageUrl: "1", type: "fire"),
//    .init(id: 5, name: "Charmeleon", imageUrl: "1", type: "fire"),
//    .init(id: 6, name: "Charizard", imageUrl: "1", type: "fire")
]
