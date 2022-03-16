//
//  NameView.swift
//  iExpense
//
//  Created by Frank Chu on 3/15/22.
//

import SwiftUI

struct NameView: View {
    @StateObject var user = User()
    @State private var showingSheet = false
    @State private var showingDelete = false

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")
            
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
            
            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SecondView(name: "@Frank")
            }
            
            Button("Show onDeleteView") {
                showingDelete.toggle()
            }
            .sheet(isPresented: $showingDelete) {
                onDeleteView()
            }
            
            
        }
        .padding()
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
    }
}
