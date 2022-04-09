//
//  ShowingMultipleOptionsWithConfirmationDialog.swift
//  Instafilter
//
//  Created by Frank Chu on 4/8/22.
//

import SwiftUI

struct ShowingMultipleOptionsWithConfirmationDialog: View {
    
    @State private var showingCOnfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello, world!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                showingCOnfirmation = true
            }
            .confirmationDialog("Change background", isPresented: $showingCOnfirmation) {
                Button("Red") { backgroundColor = .red }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a new color")
            }
    }
}

struct ShowingMultipleOptionsWithConfirmationDialog_Previews: PreviewProvider {
    static var previews: some View {
        ShowingMultipleOptionsWithConfirmationDialog()
    }
}
