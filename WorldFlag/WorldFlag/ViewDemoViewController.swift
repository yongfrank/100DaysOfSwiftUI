//
//  ViewDemoViewController.swift
//  WorldFlag
//
//  Created by Frank Chu on 1/1/23.
//

import UIKit

class ViewDemoViewController: UIViewController {
    
    private let viewA: UIView = UIView()
    private let buttonA: UIButton = UIButton(type: UIButton.ButtonType.infoDark)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewA.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        view.addSubview(viewA)
        
        viewA.layer.borderWidth = 10
        viewA.layer.borderColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        viewA.addGestureRecognizer(tapGesture)
        
        buttonA.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        view.addSubview(buttonA)
    }
    
    @objc private func tapGesture(gestureRecognizer: UIGestureRecognizer) {
        print(#function)
    }
    
    @objc private func buttonTapped() {
        print(#function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        viewA.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: 200, height: 200)
        
        self.buttonA.frame = CGRect(x: 200, y: 200, width: 50, height: 50)
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        print(#function)
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
