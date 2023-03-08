//
//  MainViewController.swift
//  Consolidation4
//
//  Created by Frank Chu on 2/9/23.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController {
    var gameLogic = GameLogic()
    //    var letterButtons = [UIButton]()
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
        do {
            try gameLogic.loadGame()
        } catch {
            print(error.localizedDescription)
            fatalError("Load failed")
        }
        
        let lettersContainerView = LettersContainerView()
        
        
        let swiftUIVC = UIHostingController(rootView: SwiftUIView())
        self.addChild(swiftUIVC)
        swiftUIVC.view.frame = CGRect(x: 0, y: 350, width: 200, height: 200)
        self.view.addSubview(swiftUIVC.view)
        swiftUIVC.didMove(toParent: self)
        
        self.view.addSubview(lettersContainerView)
        
        NSLayoutConstraint.activate([
            lettersContainerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            lettersContainerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            lettersContainerView.heightAnchor.constraint(equalToConstant: 350),
            lettersContainerView.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
