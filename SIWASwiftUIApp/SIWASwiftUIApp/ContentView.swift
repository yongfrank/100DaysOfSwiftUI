//
//  ContentView.swift
//  SIWASwiftUIApp
//
//  Created by Frank Chu on 7/14/22.
//

import AuthenticationServices
import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    @AppStorage("email") var email = ""
    @AppStorage("firstName") var firstName = ""
    @AppStorage("lastName") var lastName = ""
    @AppStorage("userId") var userId = ""
    
    private var isSignedIn: Bool {
        !userId.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if !isSignedIn {
                    SignInWithAppleButton(.signUp) { request in
//                        request.requestedScopes = [.email, .fullName]
                        configure(request)
                    } onCompletion: { result in
                        handle(result)
                    }
                    .signInWithAppleButtonStyle(
                        colorScheme == .dark ? .white : .black
                    )
                    .frame(height: 50)
                    .padding()
                    .cornerRadius(8)
                } else {
                    List {
                        Text("Logged In")
                        Text("ID: \(userId)")
                        Text("Email: \(email)")
                        Text("name: \(firstName)")
                        Button("Log out") {
                            userId = ""
                        }
                    }
                }
            }
            .navigationTitle("Sign In")
        }
    }
    
    func configure(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
//        request.nonce = ""
    }
    
    func handle(_ authResult: Result<ASAuthorization, Error>) {
        switch authResult {
        case .success(let auth):
            switch auth.credential {
            case let credential as ASAuthorizationAppleIDCredential:
//                let userid = credential.user
//                let email = credential.email
//                let firstName = credential.fullName?.givenName
//                let lastName = credential.fullName?.familyName
//                self.userId = userid
//                self.firstName = firstName ?? "Unknown"
//                self.lastName = lastName ?? "Unknown"
//                self.email = email ?? "Unknown"
                
                if let appleUser = AppleUser(credentials: credential), let appleUserData = try? JSONEncoder().encode(appleUser) {
                    UserDefaults.standard.setValue(appleUserData, forKey: appleUser.userId)
                    print("DEBUG: saved apple user", appleUser)
                }
                decode(credential)
                
            default:
                print("DEBUG: success failure")
            }
            
        case .failure(let error):
            print("DEBUG: \(error.localizedDescription) 💆 \(error)")
        }
    }
    
    func decode(_ credential: ASAuthorizationAppleIDCredential) {
        guard let appleUserData = UserDefaults.standard.data(forKey: credential.user), let appleUser = try? JSONDecoder().decode(AppleUser.self, from: appleUserData) else { return }
        print(appleUser)
    }
}

struct AppleUser: Codable {
    let userId: String
    let firstName: String
    let lastName: String
    let email: String
    
    init?(credentials: ASAuthorizationAppleIDCredential) {
        let userid = credentials.user
        let email = credentials.email
        let firstName = credentials.fullName?.givenName
        let lastName = credentials.fullName?.familyName
        
        self.userId = userid
        self.email = email ?? "Unknown"
        self.firstName = firstName ?? "Unknown"
        self.lastName = lastName ?? "Unknown"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
