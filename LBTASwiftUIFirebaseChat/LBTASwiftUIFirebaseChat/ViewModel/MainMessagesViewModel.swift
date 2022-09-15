//
//  MainMessagesViewModel.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Frank Chu on 9/7/22.
//

import Foundation

class MainMessagesViewModel: ObservableObject {
    @Published var errorMessage = ""
    
    @Published var chatUser: ChatUser?
    
    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        
        fetchCurrentUser()
    }

    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            errorMessage = "Could not find firebase uid"
            return
        }
        
        errorMessage = "\(uid)"
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: Failed to fetch current user:", error)
                return
            }
            
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
            }
            print(data)
            
            self.chatUser = .init(data: data)
            
            //            self.errorMessage = chatUser.profileImageUrl
        }
    }
    
    @Published var isUserCurrentlyLoggedOut = false
    
    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
}
