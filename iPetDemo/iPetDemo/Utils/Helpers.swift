//
//  Helpers.swift
//  iPetDemo
//
//  Created by Frank Chu on 6/12/22.
//

import Foundation
import SwiftUI

extension View {
    func centerHStack() -> some View{
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
}

func calTime(date: Date) -> Int {
    let seconds = Int(-date.timeIntervalSinceNow)
    return seconds
}
