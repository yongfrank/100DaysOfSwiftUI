//
//  ContentView.swift
//  SignInWithApple
//
//  Created by Frank Chu on 7/7/22.
//

import AuthenticationServices
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                SignInWithAppleButton(.continue) { _ in

                } onCompletion: { _ in
                    
                }
            }
            .navigationTitle("HI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
