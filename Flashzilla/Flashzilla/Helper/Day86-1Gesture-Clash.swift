//
//  Day86-1Gesture-Clash.swift
//  Flashzilla
//
//  Created by Frank Chu on 5/18/22.
//

import SwiftUI

struct Day86_1Gesture_Clash: View {
    var body: some View {
        VStack {
            Text("🤿")
                .onTapGesture {
                    print("Text tapped")
                }
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded({ _ in
                    print("VStack tapped")
                })
        )
        
//        .onTapGesture {
//            print("VStack tapped")
//        }
//        .highPriorityGesture(
//            TapGesture()
//                .onEnded({ _ in
//                    print("VStack tapped")
//                })
//        )
    }
}

struct Day86_1Gesture_Clash_Previews: PreviewProvider {
    static var previews: some View {
        Day86_1Gesture_Clash()
    }
}
