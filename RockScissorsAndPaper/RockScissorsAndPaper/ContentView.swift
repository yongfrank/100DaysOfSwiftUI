//
//  ContentView.swift
//  RockScissorsAndPaper
//
//  Created by Frank Chu on 3/7/22.
//  This is the project of day 25

import SwiftUI

// You can put anything you want in struct ThreeChoices like: 🔥 💧 🍃 ✊ ✌️ 🖐️
struct ThreeChoices {
    let rock = "💧"
    let scissor = "🔥"
    let paper = "🍃"
}
let threeChoice = ThreeChoices()

struct EmojiView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 100))
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
    
    
    @State private var winAndLoseState = [true, false]
    @State private var appsChoice = [threeChoice.rock, threeChoice.scissor, threeChoice.paper].shuffled()
    @State private var playersChoice = [threeChoice.rock, threeChoice.scissor, threeChoice.paper].shuffled()
    
    @State private var showingReset = false
    
    
    //  Algorithm credit by https://zhuanlan.zhihu.com/p/21297056
    let winCombinations = [[threeChoice.rock, threeChoice.scissor], [threeChoice.scissor, threeChoice.paper], [threeChoice.paper, threeChoice.rock]]

    @State private var scoreTitile = "      "
    @State private var playerScore = 0
    @State private var roundCount = 1
    
    //  Timer https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-a-timer-with-swiftui
    @State var timerCount = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .yellow, location: 0.3),
                .init(color: .blue, location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Spacer()
                Text("\(threeChoice.rock) \(threeChoice.scissor) \(threeChoice.paper) Quest")
                    .font(.largeTitle.bold())
                    .foregroundColor(.blue)
                
                
                
                VStack {
                    VStack {
                        Text("App's Choice")
                            .font(.title.weight(.bold))
                        Text(appsChoice[0])
                            .font(.system(size: 100))
                            
                    }
                }
                .frostedGlass()
                
                VStack {
                    VStack(spacing: 20) {
                        Text("Which one you will")
                            .font(.title.weight(.bold))
                        Text(winAndLoseState[0] ? "WIN?" : "LOSE?")
                            .font(.largeTitle.weight(.heavy))
                            .foregroundColor(.red)
                        
                        HStack {
                            ForEach(0..<3) { number in
                                Button {
                                    emojiTapped(number)
                                    nextRound()
                                } label: {
                                    EmojiView(text: playersChoice[number])
                                }
                            }
                        }
                    }
                }
                .frostedGlass()
                
                VStack {
                    Text("Result: \(scoreTitile)")
                        .font(.largeTitle.weight(.heavy))
                }
                .frostedGlass()
                
                
                VStack {
                    Text("\(timerCount)")
                        .onReceive(timer) { _ in
                            if !showingReset {
                                timerCount += 1
                            }
                        }
                }
                .frostedGlass()
                .clipShape(Circle())
                
                Spacer()
                HStack {
                    Text("Round of \(roundCount) of 10")
                    
                    Spacer()
                    
                    Text("Score: \(playerScore)")
                        .font(.title.bold())
                    
                }
                Spacer()
            }
            .padding()
            // End of Big VStack under RadialGradient
        }
        //  End of ZStack
        .alert("Game finished", isPresented: $showingReset) {
            Button("Start a New Game", action: restartGame)
        } message: {
            Text("Your final score is \(playerScore).\nYou used \(timerCount) seconds.")
        }
    }
    //  End of var body: some View
    
    func emojiTapped(_ number: Int) {
        if winAndLoseState[0] {
//            for winCombination in winCombinations {
//                if winCombination == ([playersChoice[number], appsChoice[0]]) {
//
//                }
//            }
            judgeWinOrLose(playersChoice[number], appsChoice[0])
        } else {
            judgeWinOrLose(appsChoice[0], playersChoice[number])
        }
    }

    func judgeWinOrLose(_ player: String, _ app: String){
        if winCombinations.contains([player, app]) {
            scoreTitile = "Correct"
            playerScore += 1
        } else {
            playerScore -= 1
            scoreTitile = "Wrong"
        }
    }
    
    func nextRound() {
        roundCount += 1
        if roundCount > 10 {
            roundCount = 10
            showingReset = true
        } else {
            showingReset = false
            appsChoice.shuffle()
            playersChoice.shuffle()
            winAndLoseState.shuffle()
        }
    }
    
    func restartGame() {
        playerScore = 0
        roundCount = 1
        scoreTitile = "            "
        timerCount = 0
        
        appsChoice.shuffle()
        playersChoice.shuffle()
        winAndLoseState.shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
