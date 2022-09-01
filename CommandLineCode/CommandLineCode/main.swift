//
//  main.swift
//  CommandLineCode
//
//  Created by Frank Chu on 8/1/22.
//

import Foundation

print("Hello, World!")

while true {
    print("Enter first number: ", terminator: "")
    let lhs = readLine()
    print("Enter second number: ", terminator: "")
    let rhs = readLine()
    if let rhs = rhs, let lhs = lhs {
        if let rhs = Double(rhs), let lhs = Double(lhs) {
            print(rhs + lhs)
        }
    } else {
        print("\nMeet EOF")
        break
    }
}
