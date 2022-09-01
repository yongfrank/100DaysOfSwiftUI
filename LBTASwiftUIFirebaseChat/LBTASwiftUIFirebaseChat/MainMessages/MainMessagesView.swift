//
//  MainMessagesView.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Frank Chu on 8/23/22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

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
            
            self.errorMessage = "Could not find firebase uid"
            return
            
        }
        
        self.errorMessage = "\(uid)"
        
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

class RecentMessageViewModel: ObservableObject {
    @Published var recentMessages = [ChatMessage]()
    
    init() {
        fetchRecentMessages()
    }
    
    func fetchRecentMessages() {
        guard let fromId = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
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

struct MainMessagesView: View {
    
    @State private var shouldShowLogOutOptions = false
    @State var shouldNavigateToChatLogView = false
    @ObservedObject private var vm = MainMessagesViewModel()
    
    @State var chatWithUser: ChatUser?
    
    @State private var path: [ChatUser] = []
    
    
    @ObservedObject private var recentMessageVM = RecentMessageViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                customNavBar
                messagesView
                NavigationLink(value: chatWithUser.self) {
                    Text("TEST")
                }
                .navigationDestination(for: ChatUser.self, destination: { user in
                    ChatLogView(chatWithUser: user)
                })
            }
            
            .overlay(alignment: .bottom, content: {
                newMessageButton
            })
            .toolbar(.hidden)
        }
    }
    
    /// Heading Username and online
    private var customNavBar: some View {
        HStack(spacing: 16) {
            WebImage(url: URL(string: vm.chatUser?.profileImageUrl ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipped()
                .cornerRadius(50)
                .overlay {
                    RoundedRectangle(cornerRadius: 44)
                        .stroke(Color(.label), lineWidth: 1)
                }
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 4) {
                let email = vm.chatUser?.email.replacingOccurrences(of: "@gmail.com", with: "") ?? "unfetched"
                
                Text(email.localizedCapitalized)
                    .font(.system( size: 24, weight: .bold))
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("Online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(UIColor.lightGray))
                }
            }
            Spacer()
            Button {
                shouldShowLogOutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
            }
        }
        .padding()
        .confirmationDialog(
            "Settings",
            isPresented: $shouldShowLogOutOptions,
            titleVisibility: .visible
        ) {
            Button("Sign Out", role: .destructive) {
                vm.handleSignOut()
                print("DEBUG: Handle sign out.")
            }
        } message: {
            Text("What do you want to do?")
        }
        .fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut) {
            LoginView(didcompleteLoginProcess: {
                self.vm.isUserCurrentlyLoggedOut = false
                self.vm.fetchCurrentUser()
            })
        }
    }
    
    @State private var shouldShowNewMessageScreen = false
    
    private var newMessageButton: some View {
        Button {
            shouldShowNewMessageScreen.toggle()
        } label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 5)
        }
        .fullScreenCover(isPresented: $shouldShowNewMessageScreen) {
            CreateNewMessageView(didSelectNewUser: { user in
                print("DEBUG: USER is", user.email)
                self.shouldNavigateToChatLogView.toggle()
                self.chatWithUser = user
                path.append(user)
                print("DEBUG: chat with user is", chatWithUser?.email ?? "FAILED")
            })
        }
    }
    
    private var messagesView: some View {
        ScrollView {
            ForEach(recentMessageVM.recentMessages) { message in
//                let user: ChatUser = .init(data: recentMessageVM.findInfo(uid: message.toId))
                VStack {
                    Text(String(ChatUser(data: recentMessageVM.findInfo(uid: message.toId)).email))
                    NavigationLink {
                        Text("DEStination")
                    } label: {
                        HStack {
                            Image(systemName: "person.fill")
                                .font(.system(size: 32))
                                .padding(8)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 44)
                                        .stroke(Color(.label), lineWidth: 1)
                                }
                            VStack(alignment: .leading) {
                                Text(message.fromId)
                                    .font(.system(size: 16, weight: .bold))
                                Text(message.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(.lightGray))
                            }
                            Spacer()
                            Text("22d")
                                .font(.system(size: 14, weight: .semibold))
                        }
                    }

                    Divider()
                        .padding(.vertical, 8)
            }
            .padding(.horizontal)
            
                
            }
            .padding(.bottom, 50)
        }
        .refreshable {
            recentMessageVM.fetchRecentMessages()
        }
        
    }
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 mini"))
//        MainMessagesView()
//            .preferredColorScheme(.dark)
    }
}



