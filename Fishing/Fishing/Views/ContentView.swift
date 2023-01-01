//
//  ContentView.swift
//  Fishing
//
//  Created by Frank Chu on 12/31/22.
//

import SwiftUI

struct ContentView: View {
    @State private var game: Game = Game()

    @State private var sliderValue: Double = 50.0

    @State private var alertIsVisible: Bool = false

    var body: some View {
        VStack {
            Text("🎣 Fishing 🎣")
                .font(.largeTitle)
                .padding()
            Text("\(self.game.target)")
                .font(.title)
                .bold()
                .padding()
            HStack {
                Text("1 meter")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100 meters")
            }
            
            Button(action: {
                print("Button pressed!")
                self.alertIsVisible = true
            }) {
                Text("Hit Me!")
            }
            .alert("Result", isPresented: self.$alertIsVisible) {
                Button("OK") {}
            } message: {
                Text("Slider is \(Int(self.sliderValue)), Score is \(self.game.points(sliderValue: Int(self.sliderValue)))")
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
