//
//  ViewController.swift
//  Project6b
//
//  Created by Frank Chu on 1/17/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let label1: UILabel = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.text = "THESE"
        label1.backgroundColor = .red
        label1.sizeToFit()
        
        let label2: UILabel = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.text = "ARE"
        label2.backgroundColor = .cyan
        label2.sizeToFit()
        
        let label3: UILabel = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.text = "SOME"
        label3.backgroundColor = .yellow
        label3.sizeToFit()
        
        let label4: UILabel = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.text = "AWESOME"
        label4.backgroundColor = .green
        label4.sizeToFit()
        
        let label5: UILabel = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.text = "LABELS"
        label5.backgroundColor = .orange
        label5.sizeToFit()
        
        self.view.addSubview(label1)
        self.view.addSubview(label2)
        self.view.addSubview(label3)
        self.view.addSubview(label4)
        self.view.addSubview(label5)
        
//        // [key: value]
//        let viewsDictionary: [String : UILabel] = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
//
//        for label in viewsDictionary.keys {
//            self.view.addConstraints(
//                NSLayoutConstraint.constraints(withVisualFormat: "H:[\(label)]-|", metrics: nil, views: viewsDictionary)
//            )
//        }
//
//        let matrics = ["Height": 88]
//
//        self.view.addConstraints(
//            // |, means "the edge of the view."
//            // Imagine the brackets, [ and ], are the edges of the view.
//            // The new thing in the VFL this time is the - symbol, which means "space". It's 10 points by default, but you can customize it.
//            NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label1(Height@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", metrics: matrics, views: viewsDictionary)
//        )
        
        var previousLabel: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
//            label.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            label.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 1.0 / 5.0).isActive = true
            
            if let previousLabel = previousLabel {
                label.topAnchor.constraint(equalTo: previousLabel.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            }
            
            previousLabel = label
        }
    }


}

