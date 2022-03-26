//
//  ModelData.swift
//  Edutainment
//
//  Created by Frank Chu on 3/14/22.
//

import Foundation

//  https://developer.apple.com/tutorials/swiftui/handling-user-input
//  import Combine
//
//  final class ModelData: ObservableObject {
//      var landmarks: [Landmark] = load("landmarkData.json")
//  }


var animals: [Animal] = load("AnimalData.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

