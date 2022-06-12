//
//  ContentView.swift
//  HighRollers
//
//  Created by Frank Chu on 6/12/22.
//

import SwiftUI

struct DiceResult: Identifiable, Codable {
    var id = UUID()
    var type: Int
    var number: Int
    var rolls = [Int]()
    
    var description: String {
        rolls.map(String.init).joined(separator: ",")
    }
}

class DiceViewModel: ObservableObject {
    @Published var diceResults = [DiceResult]()
    
    func rollDice(diceType: Int) -> Int {
        let randomNum = Int.random(in: 1..<diceType + 1)
        return randomNum
    }
    let savePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appending(path: "SavedDiceResults.json")
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            diceResults = try JSONDecoder().decode([DiceResult].self, from: data)
        } catch {
            print(error.localizedDescription)
            diceResults = []
        }
    }
}

struct ContentView: View {
    let diceTypes = [4, 6, 8, 10, 12, 20, 100]
    
    @AppStorage("selectedDiceTypes") var selectedDiceTypes = 4
    @AppStorage("numberOfDices") var numberOfDices = 4
    
    let columns = [GridItem(.adaptive(minimum: 60))]
    
    @ObservedObject var diceViewModel = DiceViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Type of Dice", selection: $selectedDiceTypes) {
                        ForEach(diceTypes, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Stepper("Number of dice: \(numberOfDices)", value: $numberOfDices)
                    
                    Button("Roll them!") {
                        var res = DiceResult(type: selectedDiceTypes, number: numberOfDices)
                        for _ in 1..<numberOfDices+1 {
                            res.rolls.append(Int.random(in: 1 ..< (selectedDiceTypes + 1)))
                        }
                        diceViewModel.diceResults.append(res)
                        if let data = try? JSONEncoder().encode(diceViewModel.diceResults) {
                            try? data.write(to: diceViewModel.savePath, options: [.atomic, .completeFileProtection])
                        }
//                        print(diceViewModel.diceResults.last!)
                        print(diceViewModel.savePath)
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    
                } footer: {
                    LazyVGrid(columns: columns) {
                        if diceViewModel.diceResults.last == nil {} else {
                            ForEach(0..<diceViewModel.diceResults.last!.rolls.count, id: \.self) { i in
                                Text("\(diceViewModel.diceResults.last!.rolls[i])" )
                                    .font(.largeTitle).bold()
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .aspectRatio(1, contentMode: .fit)
                                    .background(.white)
                                    .cornerRadius(20)
                                    .shadow(radius: 5)
                            }
                        }
                    }
                }
                Section("Recent Result") {
                    if diceViewModel.diceResults.last == nil {} else {
                        ForEach(diceViewModel.diceResults.reversed()) { res in
                            Text("\(res.description)")
                        }
                    }
                }
            }
            
            .navigationTitle("High Rollers")
            .toolbar {
                Button("Clear ALL") {
                    diceViewModel.diceResults = [DiceResult]()
                    if let data = try? JSONEncoder().encode("") {
                        try? data.write(to: diceViewModel.savePath, options: [.atomic, .completeFileProtection])
                    }
                }
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
