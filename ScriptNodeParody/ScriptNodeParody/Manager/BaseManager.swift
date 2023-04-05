//
//  BaseManager.swift
//  ScriptNodeParody
//
//  Created by Frank Chu on 3/25/23.
//

import Foundation

class BaseManager : NSObject {
    class var shared : BaseManager {
        return BaseManager()
    }
}
