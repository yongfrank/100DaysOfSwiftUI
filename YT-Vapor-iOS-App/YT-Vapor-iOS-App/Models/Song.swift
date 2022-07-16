//
//  Song.swift
//  YT-Vapor-iOS-App
//
//  Created by Frank Chu on 7/14/22.
//

import Foundation

struct Song: Identifiable, Codable {
    let id: UUID?
    var title: String
    
}
