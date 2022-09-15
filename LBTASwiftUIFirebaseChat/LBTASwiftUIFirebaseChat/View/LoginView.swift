//
//  LoginView.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Frank Chu on 8/5/22.
//  SwiftUI Firebase Chat 02: Signing in with Firebase Auth
//  https://youtu.be/xXjYGamyREs

import SwiftUI
import PhotosUI

struct LoginView: View {
    
    let didcompleteLoginProcess: () -> ()
    
    @State private var isLoginMode = false
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    
    @State private var shouldShowImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                scrollView
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .fullScreenCover(isPresented: $shouldShowImagePicker, content: {
                ImagePicker(image: $inputImage)
            })
        } else {
            NavigationView {
                scrollView
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .fullScreenCover(isPresented: $shouldShowImagePicker, content: {
                ImagePicker(image: $inputImage)
            })
        }
    }
    
    var scrollView: some View {
        ScrollView {
            VStack(spacing: 16) {
                Picker("Pick", selection: $isLoginMode) {
                    Text("Login")
                        .tag(true)
                    Text("Create Account")
                        .tag(false)
                }
                .pickerStyle(.segmented)
                
                
                /// Profile of Login / Register Account
                ///
                ///
                if !isLoginMode {
                    Button {
                        shouldShowImagePicker.toggle()
                    } label: {
                        VStack {
                            if let inputImage = self.inputImage {
                                Image(uiImage: inputImage)
                                    .resizable()
                                    .frame(width: 128, height: 128)
                                    .scaledToFill()
                                    .cornerRadius(64)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 64))
                                    .padding()
                                    .foregroundColor(Color(.label))
                            }
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 64)
                            .stroke(Color.black, lineWidth: 3)
                    )
                }
                
                /// Email & Password TextField
                Group {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    HStack {
                        if showPassword {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }
                    }
                    .overlay(alignment: .trailing) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .onTapGesture {
                                showPassword.toggle()
                            }
                    }
                }
                .padding(12)
                .background {
                    Color.white
                }
                
                /// Create Account Button
                Button {
                    handleAction()
                } label: {
                    HStack {
                        Spacer()
                        Text(isLoginMode ? "Log In" : "Create Account")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                        Spacer()
                    }
                    .background(.blue)
                }
                
                Text(self.loginStatusMessage)
                    .foregroundColor(.red)
                
                Button("Pikachu") {
                    isLoginMode = true
                    email = "pikachu@gmail.com"
                    password = "123123"
                    handleAction()
                }
                
                Button("Charmander") {
                    isLoginMode = true
                    email = "charmander@gmail.com"
                    password = "123123"
                    handleAction()
                }
                
            }
            .padding()
        }
        .navigationTitle(isLoginMode ? "Login" : "Create Account")
        .background {
            Color(.init(white: 0, alpha: 0.05))
                .ignoresSafeArea()
        }
    }
    
    private func handleAction() {
        if isLoginMode {
            loginUser()
            print("Debug: func loginUser()")
        } else {
            createNewAccount()
            print("Debug: Register into Firebase")
        }
    }
    
    @State var loginStatusMessage = ""
    
    private func createNewAccount() {
        if self.inputImage == nil {
            self.loginStatusMessage = "You must select an avatar image"
            return
        }
        
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to create user: ", error)
                self.loginStatusMessage = "Failed to login user: \(error.localizedDescription)"
                return
            }
            
            print("DEBUG: Successfully created user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            
            self.persistImageToStorage()
        }
    }
    
    private func persistImageToStorage() {
//        let filename = UUID().uuidString
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        
        guard let imageData = self.inputImage?.jpegData(compressionQuality: 0.5) else { return }
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                self.loginStatusMessage = "Failed to push image to Stroage: \(error)"
                return
            }
            
            ref.downloadURL { url, error in
                if let error = error {
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(error)"
                    return
                }
                
                self.loginStatusMessage = "Successfully stored image with url \(url?.absoluteString ?? "")"
                print("DEBUG: \(url?.absoluteString ?? "")")
                
                guard let url = url else { return }
                self.storeUserInformation(imageProfileUrl: url)
            }
        }
    }
    
    private func storeUserInformation(imageProfileUrl: URL) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let userData = ["email": self.email, "uid": uid, "profileImageUrl": imageProfileUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("users").document(uid).setData(userData) { error in
                if let error = error {
                    print("DEBUG: \(error.localizedDescription)")
                    return
                }
                
                print("DEBUG: success storeUserInformation")
            }
        
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to login user: ", error)
                self.loginStatusMessage = "Failed to login user: \(error.localizedDescription)"
                return
            }
            
            print("DEBUG: Successfully login user: \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Successfully login as user: \(result?.user.uid ?? "")"
            
            self.didcompleteLoginProcess()
        }
    }
    
    private func loadImage() {
//        guard let inputImage = inputImage else {
//            return
//        }
//        image = Image(uiImage: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(didcompleteLoginProcess: {
            
        })
    }
}
