//
//  SandwichStore.swift
//  Sandwiches
//
//  Created by Frank Chu on 4/9/22.
//

import Foundation

class SandwichStore: ObservableObject {
    @Published var sandwiches: [Sandwich]
    
    init(sandwiches: [Sandwich] = []) {
        self.sandwiches = sandwiches
    }
}

//let testStore = SandwichStore(sandwiches: testData)
