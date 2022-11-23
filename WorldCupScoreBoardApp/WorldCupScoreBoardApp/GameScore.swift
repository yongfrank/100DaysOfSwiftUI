//
//  GameScore.swift
//  WorldCupScoreBoardApp
//
//  Created by Frank Chu on 11/23/22.
//

import Foundation

//class GameScore: ObservableObject, Codable {
//    @Published var score1 = 1
//    @Published var score2 = 2
//    var cards1 = 1
//    var cards2 = 2
//}


/// GameScore Model
struct GameScore: Codable {
    var score1 = 1
    var score2 = 2
    var cards1 = 1
    var cards2 = 2
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    
    /// initialization of GameStore, constructor
    /// - Parameter json: json from UserDefaults
    init?(json: Data?) {
        if let json = json {
            if let newGameScore = try? JSONDecoder().decode(GameScore.self, from: json) {
                self = newGameScore
            } else {
                 return nil
            }
        } else {
            return nil
        }
        
//        if json != nil, let newGameScore = try? JSONDecoder().decode(GameScore.self, from: json!) {
//            self = newGameScore
//        } else {
//            return nil
//        }
    }
    
    init() {
        
    }
}
