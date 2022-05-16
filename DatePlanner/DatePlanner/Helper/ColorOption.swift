//
//  ColorOption.swift
//  DatePlanner
//
//  Created by Frank Chu on 4/10/22.
//

import SwiftUI

struct ColorOptions {
    static var allColorByF: [Color] = [
        .primary,
        .gray,
        .red,
        .orange,
        .indigo,
    ]
    
    static var `default` : Color = Color.primary
    
    static func randomColorByF() -> Color {
        if let element = ColorOptions.allColorByF.randomElement() {
            return element
        } else {
            return .primary
        }
    }
}
