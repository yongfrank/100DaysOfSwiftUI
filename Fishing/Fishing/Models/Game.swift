//
//  Game.swift
//  Fishing
//
//  Created by Frank Chu on 12/31/22.
//

import Foundation

struct Game {
    var target: Int = Int.random(in: 1...100)
    var score: Int = 0
    var round: Int = 1

    func points(sliderValue: Int) -> Int {
        let difference = abs(sliderValue - target)
        let bonus: Int

        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }

        return 100 - difference + bonus
    }
}
