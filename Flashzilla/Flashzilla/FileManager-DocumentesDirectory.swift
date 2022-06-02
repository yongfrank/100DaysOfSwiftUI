//
//  FileManager-DocumentesDirectory.swift
//  Flashzilla
//
//  Created by Frank Chu on 5/26/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
