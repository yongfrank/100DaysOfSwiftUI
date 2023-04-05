//
//  PageManager.swift
//  ScriptNodeParody
//
//  Created by Frank Chu on 3/25/23.
//

import Foundation

class PageManager : BaseManager {
    static let instance = PageManager()
    
    override class var shared: BaseManager {
        return self.instance
    }
    
//    @ObservedObject 
}
