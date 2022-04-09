//
//  TapView.swift
//  RecognizingGestures
//
//  Created by Frank Chu on 4/6/22.
//

import SwiftUI

struct TapView: View {
    
    @State private var colorByF : Color = Color.primary
    
    var tapGesture: some Gesture {
        TapGesture()
            .onEnded {
                withAnimation {
                    colorByF = Color.random()
                }
            }
            
    }
    
    var body: some View {
        VStack {
            Text("Tap the rectangle to change its color")
            Spacer()
            Rectangle()
                .foregroundColor(colorByF)
                .frame(width: 250, height: 125)
                .gesture(tapGesture)
            Spacer()
        }
        .navigationTitle("Tap")
        .toolbar {
            Button("Reset") {
                colorByF = Color.primary
            }
        }
    }
}

struct TapView_Previews: PreviewProvider {
    static var previews: some View {
        TapView()
    }
}


extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}
