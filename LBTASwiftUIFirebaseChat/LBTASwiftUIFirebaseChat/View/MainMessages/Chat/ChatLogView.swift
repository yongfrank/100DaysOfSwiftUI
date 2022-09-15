//
//  ChatLogView.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Frank Chu on 8/24/22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct FirebaseConstants {
    static let messages = "messages", fromId = "fromId", toId = "toId", text = "text", timestamp = "timestamp"
    static let recent_messages = "recent_messages"
    
    static let users = "users"
}

class ChatLogViewModel: ObservableObject {
    
    @Published var chatText = ""
    
    @Published var errorMessage = ""
    
    @Published var chatMessages = [ChatMessage]()
    
    let chatWithUser: ChatUser?
    
    init(chatWithUser: ChatUser?) {
        self.chatWithUser = chatWithUser
        
        fetchMessages()
        
    }
    
    private func fetchMessages() {
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let toId = chatWithUser?.uid else { return }
        
        FirebaseManager.shared.firestore.collection(FirebaseConstants.messages)
            .document(fromId)
            .collection(toId)
            .order(by: FirebaseConstants.timestamp)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for messages: \(error)"
                    print("DEBUG: \(error)")
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        self.chatMessages.append(.init(documentId: change.document.documentID, data: data))
                    }
                })
                DispatchQueue.main.async {
                    self.count += 1
                }
                //            querySnapshot?.documents.forEach({ queryDocumentSnapshot in
                //                let data = queryDocumentSnapshot.data()
                //                let docId = queryDocumentSnapshot.documentID
                //                self.chatMessages.append(.init(documentId: docId, data: data))
                //            })
            }
    }
    
    func handleSend() {
        print("DEBUG:", self.chatText)
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let toId = chatWithUser?.uid else { return }
        
        let document = FirebaseManager.shared.firestore.collection(FirebaseConstants.messages).document(fromId).collection(toId).document()
        
        let messageData = [
            FirebaseConstants.fromId: fromId,
            FirebaseConstants.toId: toId,
            FirebaseConstants.text: self.chatText,
            FirebaseConstants.timestamp: Timestamp()
        ] as [String : Any]
        
        document.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            }
            
            self.persistRecentMessage()
            
            self.chatText = ""
            self.count += 1
        }
        
        let recipientMessageDocument = FirebaseManager.shared.firestore.collection(FirebaseConstants.messages).document(toId).collection(fromId).document()
        
        recipientMessageDocument.setData(messageData) { error in
            if let error = error {
                self.errorMessage = "Failed to save message into Firestore: \(error)"
                return
            }
            print("DEBUG: Recipient saved message as well")
        }
    }
    
    private func persistRecentMessage() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let toId = self.chatWithUser?.uid else { return }
        
        let document = FirebaseManager.shared.firestore
            .collection(FirebaseConstants.recent_messages)
            .document(uid)
            .collection(FirebaseConstants.messages)
            .document(toId)
        
        let data = [
            FirebaseConstants.timestamp : Timestamp(),
            FirebaseConstants.text: self.chatText,
            FirebaseConstants.fromId: uid,
            FirebaseConstants.toId: toId
        ] as [String : Any]
        
        document.setData(data) { error in
            if let error = error {
                self.errorMessage = "Failed to save recent message: \(error)"
                print("DEBUG: Failed to private func persistRecentMessage()")
                return
            }
        }
        
        let recipient = FirebaseManager.shared.firestore
            .collection(FirebaseConstants.recent_messages)
            .document(toId)
            .collection(FirebaseConstants.messages)
            .document(uid)
        
        recipient.setData(data) { error in
            if let error = error {
                self.errorMessage = "Failed to save recent message: \(error)"
                print("DEBUG: Failed to private func persistRecentMessage()")
                return
            }
        }
    }
    
    @Published var count = 0
}

struct ChatLogView: View {
    
    let chatWithUser: ChatUser?
    
    @ObservedObject var vm: ChatLogViewModel
    
    init(chatWithUser: ChatUser?) {
        self.chatWithUser = chatWithUser
        self.vm = ChatLogViewModel(chatWithUser: chatWithUser)
    }
    
    var body: some View {
        ZStack {
            messagesView
            Text(vm.errorMessage)
        }
        .navigationTitle(chatWithUser?.email ?? "UNKNOWN EMAIL")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    static let emptyScrollToString = "Empty"
    
    private var messagesView: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    ForEach(vm.chatMessages) { message in
                        MessageView(message: message)
                    }
                    HStack { Spacer() }
                        .id(Self.emptyScrollToString)
                }
                .onReceive(vm.$count) { _ in
                    withAnimation(.easeOut(duration: 0.5)) {
                        scrollViewProxy.scrollTo(Self.emptyScrollToString, anchor: .bottom)
                    }
                }
                
                
            }
            
        }
        .background(Color(UIColor.init(white: 0.95, alpha: 1)))
        .safeAreaInset(edge: .bottom) {
            chatBottomBar
                .background(
                    Color(.systemBackground)
                        .ignoresSafeArea()
                )
        }
    }
    
    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            Button {
                
            } label: {
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.system(size: 24))
                    .foregroundColor(Color(.darkGray))
            }
            
            ZStack {
                //                DescriptionPlaceHolder()
                descriptionPlaceHolder
                TextEditor(text: $vm.chatText)
                    .opacity(vm.chatText.isEmpty ? 0.5 : 1)
            }
            .frame(height: 40)
            
            Button {
                vm.handleSend()
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(.blue)
            .cornerRadius(4)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    private var descriptionPlaceHolder: some View {
        HStack {
            Text("Description")
                .foregroundColor(.gray)
                .font(.system(size: 17))
                .padding(.leading, 5)
                .padding(.top, -4)
            Spacer()
        }
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ChatLogView(chatWithUser: ChatUser.example)
            }
        } else {
            // Fallback on earlier versions
            NavigationView {
                ChatLogView(chatWithUser: ChatUser.example)
            }
        }
        if #available(iOS 16.0, *) {
            NavigationStack {
                ChatLogView(chatWithUser: ChatUser.example)
                    .preferredColorScheme(.dark)
            }
        } else {
            // Fallback on earlier versions
            NavigationView {
                ChatLogView(chatWithUser: ChatUser.example)
                    .preferredColorScheme(.dark)
            }
        }
    }
}

struct MessageView: View {
    let message: ChatMessage
    var body: some View {
        VStack {
            if message.fromId == FirebaseManager.shared.auth.currentUser?.uid {
                HStack {
                    Spacer()
                    HStack {
                        Text(message.text)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(.blue)
                    .cornerRadius(8)
                }
            } else {
                HStack {
                    HStack {
                        Text(message.text)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(8)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}
