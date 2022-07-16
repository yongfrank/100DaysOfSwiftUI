//
//  LoginView.swift
//  LiveChat
//
//  Created by Frank Chu on 7/7/22.
//

import SwiftUI
class UserInfo: ObservableObject {
    @Published var userid: String
    
    init(id: String) {
        self.userid = id
    }
}

struct LoginView: View {
    @Binding var username: String
    var body: some View {
        ProgressView()
            .onAppear(perform: login)
    }
    func login() {
        Task {
            do {
                let userInAnonymous = try await realmApp.login(credentials: .anonymous)
                username = userInAnonymous.id
                print(username)
            } catch {
                print("Fail to log in: \(error.localizedDescription)")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(username: .constant("i"))
    }
}
