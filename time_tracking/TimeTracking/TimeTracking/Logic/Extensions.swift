//
//  Extensions.swift
//  TimeTracking
//
//  Created by Frank Chu on 10/23/22.
//

import Foundation

extension Array where Element == Clock {
    func sumAllClocks(refDate: Date = Date()) -> Int {
        var sum = 0
        for clock in self {
            sum = sum + clock.timeSegments.sumAllSegment(refDate: refDate)
        }
        return sum
    }
}

extension Array where Element == TimeSegment {
    func sumAllSegment(refDate: Date = Date()) -> Int {
        var sum = 0
        for seg in self {
            sum += seg.elapsedTime(refTime: Date())
        }
        return sum
    }
}
