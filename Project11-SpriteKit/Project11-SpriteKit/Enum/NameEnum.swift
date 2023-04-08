//
//  NameEnum.swift
//  Project11-SpriteKit
//
//  Created by Frank Chu on 4/9/23.
//

import Foundation

enum NameEnum: String {
    case good, bad, ball
}

extension NameEnum: CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}

enum Assets: String {
    case bouncer, background, slotBaseGood, slotBaseBad, slotGlowGood, slotGlowBad
    case fontChalkduster = "Chalkduster"
    case fireParticles = "FireParticles"
    
    // https://stackoverflow.com/questions/26261011/how-to-choose-a-random-enumeration-value
    enum Ball: String, CustomStringConvertible, CaseIterable {
        case ballRed, ballBlue, ballCyan, ballGreen, ballGrey, ballPurple, ballYellow
        
        var description: String {
            return self.rawValue
        }
        
        static func randomBall() -> Ball {
            return Self.allCases.randomElement() ?? ballRed
        }
    }
}

extension Assets: CustomStringConvertible {
    var description: String {
        switch self {
        default:
            return self.rawValue
//        case .ballRed:
//            return "ballRed"
//        case .bouncer:
//            return "bouncer"
//        case .background:
//            return "background"
//        case .slotBaseGood:
//            return "slotBaseGood"
//        case .slotBaseBad:
//            return "slotBaseBad"
//        case .slotGlowGood:
//            return "slotGlowGood"
//        case .slotGlowBad:
//            return "slotGlowBad"
        }
    }
}
