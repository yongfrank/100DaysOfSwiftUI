//
//  ContentView.swift
//  WordScramble
//
//  Created by Frank Chu on 3/11/22.
//

import SwiftUI

struct ErrorAlert {
    var title: String
    var message: String
    var show: Bool
    
    init(title: String = "", message: String = "", show: Bool = false) {
        self.title = title
        self.message = message
        self.show = show
    }
}

struct ContentView: View {
    @State private var usedWords = [String]()
//    @State private var usedWordsScore = [Int]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var playerScore = 0
    
    @State private var errorAlert = ErrorAlert()
    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)

                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            } // End of list
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorAlert.title, isPresented: $errorAlert.show) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorAlert.message)
            }
            .toolbar {
                Button("New Game", action: startGame)
            }
                
        } // end of NavigationView
        
        VStack {
            Text("Your score: ")
                .font(.caption)
            Text("\(playerScore)")
                .font(.largeTitle.bold())
        }
    } // end of some View
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isShort(word: answer) else {
            wordError(title: "Word too short", message: "Word is too short or word is equal to given word!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        playerScore += newWord.count
        
        newWord = ""
    }
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")

                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"

                usedWords.removeAll()
                playerScore = 0
                // If we are here everything has worked, so we can exit
                return
            }
        }

        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    // check the word is used
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    // check the word is in the words we given
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    // check the word is real
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    func isShort(word: String) -> Bool {
        if word.count < 3 || word == rootWord { return false }
        return true
    }
    func wordError(title: String, message: String) {
        errorAlert.title = title
        errorAlert.message = message
        errorAlert.show = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
