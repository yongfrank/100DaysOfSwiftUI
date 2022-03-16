//
//  SecondView.swift
//  iExpense
//
//  Created by Frank Chu on 3/15/22.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    
    var name: String
    var body: some View {
        VStack {
            Text("Second View: Hello, \(name)")
            Button("Dismiss") {
                dismiss()
            }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(name: "Frank")
    }
}
