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

struct LinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    
    init() { }
    
    mutating func push(_ data: T) {
        head = Node(data: data, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    mutating func pop() -> T? {
        defer {
            head = head?.next
            if head == nil { tail = nil }
        }
        return head?.data
    }
    
    mutating func append(_ data: T) {
        guard let _ = tail else {
            self.push(data)
            return
        }
        self.tail?.next = Node(data: data)
        self.tail = self.tail?.next
    }
    
    mutating func removeLast() -> T? {
        guard let head = self.head else { return nil }
        guard let next = self.head?.next else {
            return self.pop()
        }
        var prev: Node = head
        var current: Node = next
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        tail = prev
        tail?.next = nil
        return current.data
    }
}
