//
//  ModalType.swift
//  YT-Vapor-iOS-App
//
//  Created by Frank Chu on 7/14/22.
//

import Foundation

enum ModalType: Identifiable {
    var id: String {
        switch self {
        case .add: return "add"
        case .update: return "update"
        }
    }
    
    case add
    case update(Song)
}
