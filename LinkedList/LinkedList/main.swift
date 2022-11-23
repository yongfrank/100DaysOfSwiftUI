//
//  main.swift
//  LinkedList
//
//  Created by Frank Chu on 9/23/22.
//

import Foundation

var linkedList: LinkedList<String> = LinkedList()

while(true) {
    print("========================LINKEDLIST=========================")
    print("Please input push, pop, append, remove last and description")
    if let line = readLine() {
        if line == "exit" { break }
        var lineMode: LineMode = .pleaseInput
        for mode in LineMode.allCases {
            if line == mode.rawValue {
                lineMode = mode
            }
        }
        
        while(lineMode != .pleaseInput) {
            modeOutput(lineMode: lineMode)
            if let line = readLine() {
                if line == "b" { break }
                
                switch lineMode {
                case .push:
                    linkedList.push(line)
                case .pop:
                    print("Pop:", linkedList.pop() ?? "nil")
                case .append:
                    linkedList.append(line)
                case .removeLast:
                    print("Remove Last:", linkedList.removeLast() ?? "last is nil")
                case .description:
                    lineMode = .pleaseInput
                case .pleaseInput:
                    print("Please input push, pop, append and remove last")
                }
                
                print(linkedList.head?.description ?? "Empty")
            }
        }
    }
}

func modeOutput(lineMode: LineMode) {
    for caseOfLineMode in LineMode.allCases {
        if caseOfLineMode == lineMode {
            print(caseOfLineMode.rawValue, terminator: ": ")
        }
    }
}

enum LineMode: String, CaseIterable {
    case push = "push"
    case pop = "pop"
    case append = "append"
    case removeLast = "remove last"
    case description = "description"
    case pleaseInput = "pleaseInput"
}

class Node<T> {
    var data: T
    var next: Node?
    
    init(data: T, next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next = self.next else { return "\(self.data)"}
        return "\(self.data) -> " + String(describing: next)
    }
}
