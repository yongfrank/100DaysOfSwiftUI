//
//  Functions.swift
//  TimeTracking
//
//  Created by Frank Chu on 10/23/22.
//

import Foundation

private func secondsToHoursMinutesSeconds(_ seconds: Int) -> (String, String, String) {
    let h = seconds / 3600
    let m = (seconds % 3600) / 60
    let s = (seconds % 3600) % 60
    
    let hString = h < 10 ? "0\(h)" : "\(h)"
    let mString = m < 10 ? "0\(m)" : "\(m)"
    let sString = s < 10 ? "0\(s)" : "\(s)"
    
    return (hString, mString, sString)
}

func secondsToFullString(_ seconds: Int) -> String {
    let stringTuple: (String, String, String) = secondsToHoursMinutesSeconds(seconds)
    return "\(stringTuple.0):" + "\(stringTuple.1):" + "\(stringTuple.2)"
}
