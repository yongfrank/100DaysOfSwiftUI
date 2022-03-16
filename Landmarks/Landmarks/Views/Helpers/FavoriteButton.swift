//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by Frank Chu on 3/14/22.
//

import SwiftUI

struct FavoriteButton: View {
    
//    3.你是在你的视图中创造价值，还是从其他地方传入？
//
//    在我看来，我将在本地创造价值。
//    我将从其他地方传递值。
//    您应该使用@Binding属性包装器。
//
//    @Binding var username: String

    
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
