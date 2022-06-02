//
//  Day86-1Gesture-Combined.swift
//  Flashzilla
//
//  Created by Frank Chu on 5/18/22.
//

import SwiftUI

struct Day86_1Gesture_Combined: View {
    @State var isDragging = false
    @State var offset = CGSize.zero
    
    var body: some View {
        
        let dragGesture = DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        
        let combined = pressGesture.sequenced(before: dragGesture)
        
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}

struct Day86_1Gesture_Combined_Previews: PreviewProvider {
    static var previews: some View {
        Day86_1Gesture_Combined()
    }
}
