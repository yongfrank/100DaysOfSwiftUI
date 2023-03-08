//
//  ViewModel.swift
//  Consolidation4
//
//  Created by Frank Chu on 2/9/23.
//

import Foundation
import UIKit

enum GameLogicError: Error {
    case LoadFailed
}

private protocol GameLogicProtocol {
//    var usedLetters: [String] { get set }
//    var deactivatedButtons: Array<UIButton> { get set }
    func loadGame() throws
    func loadFilesToGetWords(_ fileName: String, _ errorWord: String) -> [String]
    func buttonPressed()
    func gameOver()
}

class GameLogic: GameLogicProtocol {
    private var usedLetters: [String] = []
    private var deactivatedButtons: Array<UIButton> = []
    private var answerWord = ""
    private var allWords: [String] = []
    private var level = 1
    private var hangmanLive = 0
    
    func loadGame() throws {
//        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//            guard let self = self else { return }
//
//        }
        self.allWords = self.loadFilesToGetWords("level\(self.level)")
        guard let answer = self.allWords.randomElement() else { throw GameLogicError.LoadFailed }
        self.answerWord = answer
        
    }
    
    func buttonPressed() {
        
    }
    
    func gameOver() {
        
    }
    
    
    fileprivate func loadFilesToGetWords(_ fileName: String, _ errorWord: String = "EXAMPLE") -> [String] {
        if let filePath = Bundle.main.url(forResource: fileName, withExtension: "txt") {
            if let contents = try? String(contentsOf: filePath) {
                let allWords: [String] = contents.components(separatedBy: "\n").filter { $0 != "" }
                return allWords
            }
        }
        return [errorWord]
    }
}
