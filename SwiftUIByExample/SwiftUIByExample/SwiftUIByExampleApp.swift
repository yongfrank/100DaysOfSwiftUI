//
//  SwiftUIByExampleApp.swift
//  SwiftUIByExample
//
//  Created by Frank Chu on 7/16/22.
//

import SwiftUI

@main
struct SwiftUIByExampleApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: TextFile()) { file in
            ContentView(document: file.$document)
        }
    }
}
