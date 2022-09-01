//
//  CreateNewMessageView.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Frank Chu on 8/24/22.
//

import SwiftUI
import SDWebImageSwiftUI

class CreateNewMessageViewModel: ObservableObject {
    
    @Published var users = [ChatUser]()
    @Published var errorMessages = ""
    
    init() {
        fetchAllUsers()
    }
    
    private func fetchAllUsers() {
        FirebaseManager.shared.firestore.collection("users").getDocuments { documentsSnapshot, error in
                if let error = error {
                    self.errorMessages = "DEBUG: Failed to fetch users: \(error)"
                    print("DEBUG: Failed to fetch users: \(error)")
                    return
                }
                documentsSnapshot?.documents.forEach({ snapshot in
                    guard let data = snapshot.data() else { return }
                    let user = ChatUser(data: data)
                    if user.uid != FirebaseManager.shared.auth.currentUser?.uid {
                        self.users.append(.init(data: data))
                    }
                })
            }
    }
}

struct CreateNewMessageView: View {
    
    let didSelectNewUser: (ChatUser) -> ()
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var vm = CreateNewMessageViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
//                Text("DEBUG: \(vm.errorMessages)")
                ForEach(vm.users) { user in
                    
                    Button {
                        didSelectNewUser(user)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            WebImage(url: URL(string: user.profileImageUrl))
                                .resizable()
                                .frame(width: 50, height: 50)
                                .scaledToFill()
                                .clipped()
                                .cornerRadius(50)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color(.label), lineWidth: 2)
                                }
                            
                            VStack(alignment: .leading) {
                                Text(user.email)
                                Text(user.uid)
                            }
                            .foregroundColor(.black)
                            Spacer()
                        }
                        
                    }
                    .padding(.horizontal)
                    Divider()
                        .padding(.vertical, 8)
                }
            }
            .navigationTitle("New Message")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

struct CreateNewMessageView_Previews: PreviewProvider {
    static var previews: some View {
//        MainMessagesView()
        CreateNewMessageView(didSelectNewUser: { user in
            
        })
    }
}
