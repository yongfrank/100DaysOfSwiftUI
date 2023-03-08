//
//  test.swift
//  CLILeetcode
//
//  Created by Frank Chu on 2/9/23.
//

import Foundation

struct Stack<T> {
    private var datas: Array<T> = []
    
    mutating func push(_ data: T) {
        self.datas.append(data)
    }
    
    mutating func pop() -> T? {
        self.datas.popLast()
    }
}

class CQueue {
    private var stack1 = Stack<Int>()
    private var stack2 = Stack<Int>()

    init() {
        
    }
    
    func appendTail(_ value: Int) {
        stack1.push(value)
    }
    
    func deleteHead() -> Int {
        if let popData = stack2.pop() {
            return popData
        }
        
        while let transferData = stack1.pop() {
            stack2.push(transferData)
        }
        
        return stack2.pop() ?? -1
    }
}
