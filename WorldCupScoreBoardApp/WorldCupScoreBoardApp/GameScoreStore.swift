//
//  GameScoreStore.swift
//  WorldCupScoreBoardApp
//
//  Created by Frank Chu on 11/23/22.
//

import Foundation

class GameScoreStore: ObservableObject {
    private static let key = "WorldCup"
    
    @Published private var gameScore: GameScore {
        didSet {
            UserDefaults.standard.set(gameScore.json, forKey: GameScoreStore.key)
        }
    }
    
    init() {
        self.gameScore = GameScore(json: UserDefaults.standard.data(forKey: GameScoreStore.key) ) ?? GameScore()
    }
    
    // MARK: - Intent(s)
    func addScore1() {
        gameScore.score1 += 1
    }
    
    func addScore2() {
        gameScore.score2 += 1
    }
    
    func getScore1() -> Int {
        return gameScore.score1
    }
}
