//
//  TypeFilteredButtonView.swift
//  PokedexSwiftUI
//
//  Created by Frank Chu on 6/11/22.
//

import SwiftUI

struct TypeFilteredButtonView: View {
    
    var imgName: String
    var backgroundColor: Color = .purple
    
    var height: CGFloat = 24
    var width: CGFloat = 24
    
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(imgName)
                .resizable()
                .frame(width: width, height: height)
                .padding(16)
        }
        .background(backgroundColor)
        .foregroundColor(.white)
        .clipShape(Circle())
        .shadow(color: .black, radius: 30)
        
    }
}

struct TypeFilteredButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TypeFilteredButtonView(imgName: "fire", backgroundColor: .red) {
            
        }
    }
}
