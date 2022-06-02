//
//  Card.swift
//  Flashzilla
//
//  Created by Frank Chu on 5/20/22.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    var id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
//    @State var cards = [Card](repeating: Card.example, count: 10)
    
}
