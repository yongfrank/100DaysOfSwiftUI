//
//  ViewController.swift
//  Project8
//
//  Created by Frank Chu on 1/23/23.
//

import UIKit

// We’re going to be making a word game based on the popular indie game 7 Little Words. Users are going to see a list of hints and an array of buttons with different letters on, and need to use those buttons to enter words matching the hints.
class ViewController: UIViewController {
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .white
        
        self.scoreLabel = UILabel()
        self.scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scoreLabel.textAlignment = .right
        self.scoreLabel.text = "Score: 0"
        self.view.addSubview(self.scoreLabel)
        
        self.cluesLabel = UILabel()
        self.cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.cluesLabel.font = UIFont.systemFont(ofSize: 24)
        self.cluesLabel.text = "CLUES"
        self.cluesLabel.numberOfLines = 0
        self.cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        self.view.addSubview(self.cluesLabel)
        
        self.answersLabel = UILabel()
        self.answersLabel.translatesAutoresizingMaskIntoConstraints = false
        self.answersLabel.font = UIFont.systemFont(ofSize: 24)
        self.answersLabel.text = "ANSWERS"
        self.answersLabel.textAlignment = .right
        self.answersLabel.numberOfLines = 0
        self.answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        self.view.addSubview(self.answersLabel)
        
        self.currentAnswer = UITextField()
        self.currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        self.currentAnswer.placeholder = "Tap letters to Guess"
        self.currentAnswer.textAlignment = .center
        self.currentAnswer.font = UIFont.systemFont(ofSize: 44)
        self.currentAnswer.isUserInteractionEnabled = false
        self.view.addSubview(self.currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        self.view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        self.view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(buttonsView)
        
        
        NSLayoutConstraint.activate([
            self.scoreLabel.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.scoreLabel.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            
            self.cluesLabel.topAnchor.constraint(equalTo: self.scoreLabel.bottomAnchor),
            self.cluesLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 100),
            self.cluesLabel.widthAnchor.constraint(equalTo: self.view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            
            self.answersLabel.topAnchor.constraint(equalTo: self.scoreLabel.bottomAnchor),
            self.answersLabel.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: -100),
            self.answersLabel.widthAnchor.constraint(equalTo: self.view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            self.answersLabel.heightAnchor.constraint(equalTo: self.cluesLabel.heightAnchor),
            
            self.currentAnswer.topAnchor.constraint(equalTo: self.cluesLabel.bottomAnchor, constant: 20),
            self.currentAnswer.centerXAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerXAnchor),
            self.currentAnswer.widthAnchor.constraint(equalTo: self.view.layoutMarginsGuide.widthAnchor, multiplier: 0.6),
            
            submit.topAnchor.constraint(equalTo: self.currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            clear.topAnchor.constraint(equalTo: self.currentAnswer.bottomAnchor),
            clear.centerXAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerXAnchor, constant: 100),
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
        let width = 150
        let height = 80
        
        for row in 0..<4 {
            for coloum in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                
                let frame = CGRect(x: coloum * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                self.letterButtons.append(letterButton)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

