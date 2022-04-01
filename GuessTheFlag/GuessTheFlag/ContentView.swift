//
//  ContentView.swift
//  GuessTheFlag
//  Project 2 Day 20
//  Created by Frank Chu on 3/1/22.
//

import SwiftUI

struct FlagView: View {
    var text: String
    
    var body: some View {
        Image(text)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FrostedGlass: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

extension View {
    func frostedGlass() -> some View {
        modifier(FrostedGlass())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var scoreTitle = ""
    @State private var playerScore = 0
    @State private var roundCount = 1
    
    @State private var showingScore = false
    @State private var showingReset = false
    
    // Amimation things
    @State private var animationAmount = 0.0
    @State private var opacityAmount = 2.0
    
    @State private var buttonChoosed = 1
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
//                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            withAnimation {
                                animationAmount += 360
                                opacityAmount = 0.5
                            }
                        } label: {
                            FlagView(text: countries[number])
                        }
                        .rotation3DEffect(.degrees(number == buttonChoosed ? animationAmount: 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(number == buttonChoosed ? 2 : opacityAmount)
                        
                    }
                }
                .frostedGlass()
                
                
                Spacer()
                
                VStack {
                    Text("\(scoreTitle)")
                        .font(.title.bold())
                        .frame(width: 300, height: 70, alignment: .center)
//                        .fixedSize(horizontal: true, vertical: true)
//                        .lineLimit(2)
                    HStack {
                        Spacer()
                        Button("Continue", action: askQuestion)
                        Spacer()
                        Button("Restart", action: restartGame)
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                }
                .frostedGlass()
                
                
                Spacer()
                
                HStack {
//                    Spacer()
                    
                    Text("Round \(roundCount) of 8")
                        .foregroundColor(.white)
                    
                    Spacer()
//                    Spacer()
                    
                    Text("Score: \(playerScore)")
                        .foregroundColor(.white)
                        .font(.title.bold())
                    
//                    Spacer()
                }
                
                Spacer()
            }
            .padding()
        }
        
        
//        .alert(scoreTitle, isPresented: $showingScore) {
//            Button("Continue", action: askQuestion)
//        } message: {
//            Text("Your score is \(playerScore)")
//        }
        .alert("Result", isPresented: $showingReset) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your final score is \(playerScore), press to restart the game!")
        }
        
//        {
//            Button("Continue", action: askQuestion)
//        } message: {
//            Text("Your score is \(playerScore)")
//        }
        
    }
    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            playerScore += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        
        buttonChoosed = number
        showingScore = true
    }
    
    func askQuestion() {
        
        roundCount += 1
        if roundCount > 8 {
            roundCount = 8
            showingReset = true
            
            opacityAmount = 0.5
        } else {
            showingReset = false
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            
            scoreTitle = ""
            opacityAmount = 2
        }
        
    }
    
    func restartGame() {
        
        playerScore = 0
        roundCount = 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        scoreTitle = ""
        opacityAmount = 2
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
