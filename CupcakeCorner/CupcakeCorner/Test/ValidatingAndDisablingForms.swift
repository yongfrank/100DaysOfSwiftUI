//
//  ValidatingAndDisablingForms.swift
//  CupcakeCorner
//
//  Created by Frank Chu on 4/1/22.
//  https://www.hackingwithswift.com/books/ios-swiftui/validating-and-disabling-forms

import SwiftUI

struct ValidatingAndDisablingForms: View {
    @State private var username = ""
    @State private var email = ""
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                TextField("Email", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
                .disabled(disableForm)
            }
        }
        
    }
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
}

struct ValidatingAndDisablingForms_Previews: PreviewProvider {
    static var previews: some View {
        ValidatingAndDisablingForms()
    }
}
