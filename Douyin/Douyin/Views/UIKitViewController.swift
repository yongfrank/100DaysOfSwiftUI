//
//  UIKitViewController.swift
//  Douyin
//
//  Created by Frank Chu on 5/11/23.
//

import UIKit

class UIKitViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let text = UILabel(frame: CGRect(x: 20, y: 20, width: 300, height: 300))
        text.text = "UIKit Preview Testing"
        self.view.addSubview(text)
        
        self.view.backgroundColor = UIColor .red
    }
}

#if DEBUG

import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIKitViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        UIKitViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}

#endif
