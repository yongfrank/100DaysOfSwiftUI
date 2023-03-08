//
//  LettersContainerView.swift
//  Consolidation4
//
//  Created by Frank Chu on 2/9/23.
//

import UIKit

class LettersContainerView: UIView {
    var button: UIButton!
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configure()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .systemYellow
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
