//
//  onDelete.swift
//  iExpense
//
//  Created by Frank Chu on 6/27/22.
//

import SwiftUI

struct onDelete: View {
    @State private var numbers = UserDefaults.standard.integer(forKey: "NUMNOW")
    @State private var numNow = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Now is \(numbers)")
                Button("add") {
                    numNow += 1
                    numbers = numNow
                    UserDefaults.standard.set(numNow, forKey: "NUMNOW")
                }
            }
            .toolbar {
                EditButton()
            }
//            .navigationBarHidden(true)
        }
        
    }
}

struct onDelete_Previews: PreviewProvider {
    static var previews: some View {
        onDelete()
    }
}
