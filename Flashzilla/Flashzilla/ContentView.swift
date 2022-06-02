//
//  ContentView.swift
//  Flashzilla
//
//  Created by Frank Chu on 5/17/22.
//

import SwiftUI

import CoreHaptics


struct ContentView: View {
    
//    @State var cards = [Card]()
    
    @State private var cards = DataManager.load()
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    let defaultTime = 100
    
    @State private var timeRemaining = 20
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @State var showingEditScreen = false

    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(Array(cards.enumerated()), id: \.element) { item in
                        CardView(card: item.element) { reinsert in
                            withAnimation {
                                removeCard(at: item.offset, reinsert: reinsert)
                            }
                        }
                        .stacked(at: item.offset, in: cards.count)
                        .allowsHitTesting(item.offset == cards.count - 1)
                        .accessibilityHidden(item.offset < cards.count - 1)
                    }
                    if cards.isEmpty {
                        Button("Start Again", action: resetCards)
                            .padding()
                            .background(.white)
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, reinsert: true)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())

                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1, reinsert: false)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Right")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
                .allowsHitTesting(timeRemaining > 0)
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: {
            EditCards()
        })
        .onAppear(perform: resetCards)
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newValue in
            if newValue == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
//                isActive = true
            } else {
                isActive = false
            }
        }
    }
    
    func removeCard(at index: Int, reinsert: Bool) {
        guard index >= 0 else { return }
        
        
        if reinsert {
            cards.move(fromOffsets: IndexSet(integer: index), toOffset: 0)
        } else {
            cards.remove(at: index)
            if cards.isEmpty {
                isActive = false
            }
        }
        
        
    }
    
    func resetCards() {
//        cards = [Card](repeating: Card.example, count: 10)
        loadData()
        timeRemaining = defaultTime
        isActive = true
    }
    
    func loadData() {
//        if let data = UserDefaults.standard.data(forKey: "Cards") {
//            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
//                cards = decoded
//            }
//        }
        cards = DataManager.load()
    }
}


extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
            .previewDevice("iPhone 13 Pro")
        
    }
}

