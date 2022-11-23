//
//  ContentView.swift
//  WorldCupScoreBoardApp
//
//  Created by Frank Chu on 11/23/22.
//

import SwiftUI

struct ContentView: View {
//    @StateObject var score = GameScoreStore
    @EnvironmentObject var gameScoreStore: GameScoreStore
    var body: some View {
        NavigationView {
            VStack {
                Text("The score of 🏴󠁧󠁢󠁳󠁣󠁴󠁿 is \(gameScoreStore.getScore1())")
                    .font(.title)
//                Text("\(score.score2)")
//                    .font(.title)
//                Text("\(score.cards1)")
//                    .font(.title)
//                Text("\(score.cards2)")
//                    .font(.title)
                NavigationLink(destination: ScoreView()) {
                    Text("View Scores...")
                        .font(.title)
                        .padding()
                }
                NavigationLink(destination: ScoreView2(score: gameScoreStore)) {
                    Text("View Scores...")
                        .font(.title)
                        .padding()
                }
            }
            #if !os(macOS)
            .navigationTitle("World Cup: 🇮🇳 vs 🏴󠁧󠁢󠁥󠁮󠁧󠁿")
            #endif
            .padding()
        }
    }
}

struct ScoreView: View {
    @EnvironmentObject var score: GameScoreStore
    var body: some View {
        Button("Add Score") {
            score.addScore1()
        }
        .buttonStyle(.bordered)
    }
}

struct ScoreView2: View {
    @ObservedObject var score: GameScoreStore
    var body: some View {
        Button("Add Score") {
            score.addScore1()
        }
        .buttonStyle(.bordered)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameScoreStore())
    }
}
