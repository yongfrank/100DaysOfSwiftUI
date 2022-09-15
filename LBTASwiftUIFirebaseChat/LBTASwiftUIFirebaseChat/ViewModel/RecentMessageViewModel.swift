//
//  RecentMessageViewModel.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Frank Chu on 9/7/22.
//

import Foundation

class RecentMessageViewModel: ObservableObject {
    @Published var recentMessages = [ChatMessage]()
    
    init() {
        fetchRecentMessages()
    }
    
    func fetchRecentMessages() {
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        self.recentMessages = [ChatMessage]()
        
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.recent_messages)
            .document(fromId)
            .collection(FirebaseConstants.messages)
            .order(by: FirebaseConstants.timestamp, descending: true)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("DEBUG: handleRecentMessages failed \(error)")
                    return
                }
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        self.recentMessages.append(.init(documentId: change.document.documentID, data: data))
                    }
                })
            }
    }
    
    func findInfo(uid: String) -> [String: Any] {
        var returnData = [String: Any]()
        FirebaseManager.shared.firestore
            .collection(FirebaseConstants.users)
            .document(uid)
            .getDocument { snapshot, error in
                if let error = error {
                    print("DEBUG: func findInfo(uid:) failed. ERROR: \(error)")
                    return
                }
                guard let data = snapshot?.data() else {
                    print("DEBUG: func findInfo(uid:) data failed. ERROR")
                    return
                }
                returnData = data
            }
        return returnData
    }
}
