//
//  PokemonViewModel.swift
//  PokedexSwiftUI
//
//  Created by Frank Chu on 6/11/22.
//
import SwiftUI
import Foundation

class PokemonViewModel: ObservableObject {
    @Published var pokemons = [Pokemon]()
    @Published var filteredPokemon = [Pokemon]()
    
    let baseURL = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    init() {
        fetchPokemon()
    }
    
    func fetchPokemon() {
        guard let url = URL(string: baseURL) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data?.parseData(removeString: "null,") else { return }
            guard let pokemon = try? JSONDecoder().decode([Pokemon].self, from: data) else { return }
            DispatchQueue.main.async {
                self.pokemons = pokemon
            }
        }
        .resume()
    }
    
    func backgroundColor(forType type: String) -> UIColor {
        switch type {
        case "fire": return .systemRed
        case "poison": return .systemGreen
        case "water": return .systemBlue
        case "electric": return .systemYellow
        case "psychic": return .systemPurple
        case "normal": return .systemOrange
        case "ground": return .systemGray
        case "flying": return .systemTeal
        case "fairy": return . systemPink
        default: return .systemIndigo
        }
    }
    
    func filterPokemon(by filter: String) {
        filteredPokemon = pokemons.filter { $0.type == filter }
//        print(filteredPokemon)
//        print("Filter is working")
    }
}

extension Data {
    func parseData(removeString: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataInString = dataAsString?.replacingOccurrences(of: removeString, with: "")
        guard let data = parsedDataInString?.data(using: .utf8) else { return nil }
        return data
    }
}

func bgColor(forType type: String) -> UIColor {
    switch type {
    case "fire": return .systemRed
    case "poison": return .systemGreen
    case "water": return .systemBlue
    case "electric": return .systemYellow
    case "psychic": return .systemPurple
    case "normal": return .systemOrange
    case "ground": return .systemGray
    case "flying": return .systemTeal
    case "fairy": return . systemPink
    default: return .systemIndigo
    }
}
