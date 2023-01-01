//
//  ViewController.swift
//  WorldFlag
//
//  Created by Frank Chu on 1/1/23.
//

import UIKit

class ViewController: UIViewController {

    static var newVCDidLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if !Self.newVCDidLoad {
            Self.newVCDidLoad = true
            let vc = ViewController(nibName: "View", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

