//
//  UserSwiftUI.swift
//  iExpense
//
//  Created by Frank Chu on 3/15/22.
//

import SwiftUI

struct UserSwiftUI: View {
    @State private var user = UserSwift(firstName: "Taylor", lastName: "Swift")
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct UserSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        UserSwiftUI()
    }
}
