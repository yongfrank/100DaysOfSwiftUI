//
//  ViewController.swift
//  Project5
//
//  Created by Frank Chu on 1/8/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let url = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: url) {
                // line break \n
                self.allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            self.allWords = ["silkworm"]
        }
        
        startGame()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(alertTextField))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Restart", style: .plain, target: self, action: #selector(startGame))
    }
    
    @objc func alertTextField() {
        let alertController = UIAlertController(title: "Anagram Game", message: "Enter Words", preferredStyle: .alert)
        alertController.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alertController] _ in
            guard let self = self else { return }
            guard let answer = alertController?.textFields?.first?.text else { return }
            self.submitAnswer(answer)
        }
        
        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempTitleWord = title?.lowercased() else { return false }
        
        if word == tempTitleWord { return false }
        
        for letter in word {
            if let position = tempTitleWord.firstIndex(of: letter) {
                tempTitleWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        if word.count < 3 { return false }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange: NSRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    
    func submitAnswer(_ answer: String) {
        let errorTitle: String
        let errorMessage: String
        
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    self.usedWords.insert(lowerAnswer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                } else {
                    (errorTitle, errorMessage) = showErrorMessage(error: .real)
                }
            } else {
                (errorTitle, errorMessage) = showErrorMessage(error: .original)
            }
        } else {
            guard let title = title?.lowercased() else { return }
            (errorTitle, errorMessage) = showErrorMessage(error: .possible, title: title)
        }
        
        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
    enum WordError {
        case real, original, possible
    }
    
    func showErrorMessage(error: WordError, title: String = "") -> (String, String) {
        var errorTitle = ""
        var errorMessage = ""
        switch error {
        
        case .real:
            errorTitle = "Word not recognised"
            errorMessage = "You can't just make them up, you know!"
        case .original:
            errorTitle = "Word used already"
            errorMessage = "Be more original!"
        case .possible:
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title)"
        }
        return (errorTitle, errorMessage)
    }
    
    @objc func startGame() {
        // UIViewController
        self.title = self.allWords.randomElement()
        self.usedWords.removeAll(keepingCapacity: true)
        // UITableView
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        var context: UIListContentConfiguration = cell.defaultContentConfiguration()
        context.text = usedWords[indexPath.row]
        cell.contentConfiguration = context
        
//        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}

