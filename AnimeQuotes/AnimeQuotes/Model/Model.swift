//
//  Model.swift
//  AnimeQuotes
//
//  Created by Frank Chu on 6/12/22.
//

import Foundation

struct Quote: Codable, Identifiable {
    var id = UUID()
    let anime: String
    let character: String
    let quote: String
    
    enum CodingKeys: String, CodingKey {
        case anime, character, quote
    }
    
    static let SampleQuotes: [Quote] = Bundle.main.decode("quotes.json")
    static let SampleQuote = SampleQuotes.first!
}


extension Bundle {
    func decode() {
        
    }
}
