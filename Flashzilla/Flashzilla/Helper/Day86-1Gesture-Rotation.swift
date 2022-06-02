//
//  Day86-1Gusture-Rotation.swift
//  Flashzilla
//
//  Created by Frank Chu on 5/17/22.
//

import Foundation
import SwiftUI

struct Day86_2Gesture_Rotation: View {
    @State var currentAmount = Angle.zero
    @State var finalAmount = Angle.zero
    
    var body: some View {
        Text("Hello, world!")
            .rotationEffect(currentAmount + finalAmount)
            .gesture(
                RotationGesture()
                    .onChanged({ angle in
                        currentAmount = angle
                        print(angle)
                    })
                    .onEnded({ angle in
                        finalAmount += currentAmount
                        currentAmount = .zero
                    })
            )
        
    }
}

struct Day86_2Gesture_Rotation_Previews: PreviewProvider {
    static var previews: some View {
        Day86_2Gesture_Rotation()
    }
}
