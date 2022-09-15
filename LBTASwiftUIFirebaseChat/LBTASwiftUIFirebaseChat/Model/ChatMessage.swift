//
//  ChatMessage.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Frank Chu on 9/7/22.
//

import Foundation

struct ChatMessage: Identifiable {
    var id: String { documentId }
    
    let documentId: String
    
    let fromId, toId, text: String
    let timestamp: Date
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.fromId = data[FirebaseConstants.fromId] as? String ?? ""
        self.toId = data[FirebaseConstants.toId] as? String ?? ""
        self.text = data[FirebaseConstants.text] as? String ?? ""
        self.timestamp = data[FirebaseConstants.timestamp] as? Date ?? Date()
    }
}
