//
//  Day87-3Supporting-specific-accessibility-needs-with-swiftui.swift
//  Flashzilla
//
//  Created by Frank Chu on 5/19/22.
//

import SwiftUI

struct Day87_3Supporting_specific_accessibility_needs_with_swiftui: View {
    
    ///  https://www.hackingwithswift.com/books/ios-swiftui/supporting-specific-accessibility-needs-with-swiftui
    
//    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    @State var scale = 1.0
    
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            Text("Success")
        }
        .padding()
        .background(reduceTransparency ? .black : .black.opacity(0.5))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .scaleEffect(scale)
        .onTapGesture {
//            if reduceMotion {
//                scale *= 1.5
//            } else {
//                withAnimation {
//                    scale *= 1.5
//                }
//            }
//            withOptionalAnimation {
//                scale *= 1.5
//            }
            withOptionalAnimation {
                scale *= 1.5
            }
        }
    }
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

struct Day87_3Supporting_specific_accessibility_needs_with_swiftui_Previews: PreviewProvider {
    static var previews: some View {
        Day87_3Supporting_specific_accessibility_needs_with_swiftui()
    }
}
