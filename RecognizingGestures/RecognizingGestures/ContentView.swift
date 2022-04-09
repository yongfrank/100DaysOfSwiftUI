//
//  ContentView.swift
//  RecognizingGestures
//
//  Created by Frank Chu on 4/6/22.
//  https://developer.apple.com/tutorials/sample-apps/recognizinggestures

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: TapView()) {
                    GestureRow(title: "Tap", description: "Tap a shape to interact with it.", SFSymbol: "hand.point.up.left")
                }
                
                NavigationLink {
                    LongPressView()
                } label: {
                    GestureRow(title: "Touch and Hold", description: "Touch and hold a shape to interact with it.", SFSymbol: "hand.tap")
                }
                
                NavigationLink(destination: DragView()) {
                    GestureRow(title: "Drag", description: "Drag a shape using one finger.", SFSymbol: "arrow.up.and.down.and.arrow.left.and.right")
                }
                
                NavigationLink(destination: RotateView()) {
                    GestureRow(title: "Rotate", description: "Rotate a shape with two fingers.", SFSymbol: "arrow.triangle.2.circlepath")
                }
                
                NavigationLink(destination: SingleLine()) {
                    GestureRow(title: "Line Drawing", description: "Use your finger to draw a simple line shape.", SFSymbol: "pencil.tip")
                }
            }
            .navigationTitle("Gestures")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
