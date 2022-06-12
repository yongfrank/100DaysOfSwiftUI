//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Frank Chu on 6/9/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
