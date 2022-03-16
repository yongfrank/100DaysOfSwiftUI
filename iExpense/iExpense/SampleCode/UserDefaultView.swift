//
//  UserDefaultView.swift
//  iExpense
//
//  Created by Frank Chu on 3/15/22.
//

import SwiftUI

struct UserDefaultView: View {
    @AppStorage("tapCount") private var tapCount = 0

    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
    }
}

struct UserDefaultView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultView()
            .previewLayout(.fixed(width: 300, height: 80))
    }
}
