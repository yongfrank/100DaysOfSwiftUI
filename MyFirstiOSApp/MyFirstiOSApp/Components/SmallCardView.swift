//
//  SmallCardView.swift
//  MyFirstiOSApp
//
//  Created by Frank Chu on 4/19/22.
//

import SwiftUI

struct SmallCardView: View {
    var item: Item = items[2]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 99)
                .frame(maxWidth: .infinity)
            Text(item.title)
                .font(.headline)
                .fontWeight(.bold)
            Text("20 sections - 3 hours")
                .opacity(0.7)
            
        }
        .foregroundColor(.white)
        .padding(16)
        .frame(height: 222)
        .background(item.gradient)
        .cornerRadius(30)
    }
}

struct SmallCardView_Previews: PreviewProvider {
    static var previews: some View {
        SmallCardView()
    }
}
