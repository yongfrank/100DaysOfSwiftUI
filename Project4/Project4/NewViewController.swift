//
//  NewViewController.swift
//  Project4
//
//  Created by Frank Chu on 1/5/23.
//

import UIKit
import WebKit

class NewViewController: UIViewController {

    @IBOutlet var buttonView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonView.layer.borderWidth = 1
        buttonView.layer.borderColor = UIColor.red.cgColor
        
    }

}
