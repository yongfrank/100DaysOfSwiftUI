//
//  ListItem.swift
//  MyFirstiOSApp
//
//  Created by Frank Chu on 4/19/22.
//

import SwiftUI

struct ListItem: View {
    var body: some View {
        HStack {
            Image(systemName: "sun.haze.fill")
                .renderingMode(.original)
                .frame(width: 36, height: 36)
                .foregroundColor(.white)
                .background(.black)
                .mask(Circle())
            VStack(alignment: .leading) {
                Text("Hntor to iOS Design!")
                Text("Design an iOS app from scratch for iOS 13, iPadOS and Big Sur")
            }
            .padding(.vertical)
        }
    }
}

struct ListItem_Previews: PreviewProvider {
    static var previews: some View {
        ListItem()
    }
}
