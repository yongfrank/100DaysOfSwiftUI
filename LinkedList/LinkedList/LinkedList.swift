//
//  LinkedList.swift
//  LinkedList
//
//  Created by Frank Chu on 9/30/22.
//

import Foundation

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
