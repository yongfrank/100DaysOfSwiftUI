//
//  Day86-3allowsHitTesting.swift
//  Flashzilla
//
//  Created by Frank Chu on 5/19/22.
//

import SwiftUI

struct Day86_3allowsHitTesting: View {
    
    @State var randomlyToggle = false
    var body: some View {
        ZStack {
            Rectangle()
                .fill(randomlyToggle ? .blue : .yellow)
                .ignoresSafeArea()
                .onTapGesture {
                    print("Rectangle tapped!")
                }
            
            
            VStack {
                Circle()
                ZStack {
                    Rectangle()
                    Text("DIVIDE")
                        .foregroundColor(.white)
                }
                Circle()
            }
            .padding()
            .contentShape(Rectangle())
            .onTapGesture {
                print("DIVIDED tapped")
                randomlyToggle.toggle()
            }
            
//            .allowsHitTesting(false)
                
//            VStack {
//                Text("Hello")
//                Spacer().frame(height: 100)
//                Text("world")
//
//            }
//            .contentShape(Rectangle())
//            .onTapGesture {
//                print("VStack tapped!")
//            }
        }
    }
}

struct Day86_3allowsHitTesting_Previews: PreviewProvider {
    static var previews: some View {
        Day86_3allowsHitTesting()
    }
}
