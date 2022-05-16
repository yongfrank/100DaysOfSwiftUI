//
//  DrawingDocument.swift
//  DrawingDocApp
//
//  Created by Frank Chu on 4/14/22.
//

import Foundation

struct DrawingDocument: Identifiable {
    let id: UUID
    var data: Data
    let name: String
}
