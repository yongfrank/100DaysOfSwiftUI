//
//  SwiftUIView.swift
//  Drawing
//
//  Created by Frank Chu on 3/19/22.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom)
            .frame(width: 300, height: 200, alignment: .leading)
        
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
