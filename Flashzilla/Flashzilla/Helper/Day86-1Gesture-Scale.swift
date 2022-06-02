//
//  Day86-1Gesture-Scale.swift
//  Flashzilla
//
//  Created by Frank Chu on 5/17/22.
//

import Foundation
import SwiftUI

struct Day86_1Gesture_Scale: View {
    @State var textContent = "Hello, world!"
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    var body: some View {
        Text(textContent)
            .padding()
            .scaleEffect(finalAmount + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged({ amount in
                        currentAmount = amount - 1
                        print(amount)
                    })
                    .onEnded({ amount in
                        finalAmount += currentAmount
                        currentAmount = 0
                        print("End!")
                    })

            )
        
//            .onTapGesture(count: 2) {
//                print("Double tapped!")
//            }
//            .onLongPressGesture(minimumDuration: 4) {
//                print("Long pressed!")
//                textContent = "Hi Frank"
//            } onPressingChanged: { inProgess in
//                print("In progress: \(inProgess)!")
//            }
    }
}

struct Day86_1Gesture_Scale_Previews: PreviewProvider {
    static var previews: some View {
        Day86_1Gesture_Scale()
    }
}
