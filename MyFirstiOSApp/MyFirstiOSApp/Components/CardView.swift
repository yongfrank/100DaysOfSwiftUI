//
//  CardView.swift
//  MyFirstiOSApp
//
//  Created by Frank Chu on 4/19/22.
//

import SwiftUI

struct CardView: View {
    var item: Item = items[2]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 128)
                .frame(maxWidth: .infinity)
            Text(item.title)
                .font(.title)
                .fontWeight(.bold)
            Text(item.text)
                .lineLimit(2)
                .opacity(0.7)
            Text("20 sections - 3 hours")
                .opacity(0.7)
            
        }
        .foregroundColor(.white)
        .padding(16)
        .frame(width: 252, height: 329)
        .background(item.gradient)
        .cornerRadius(30)
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
