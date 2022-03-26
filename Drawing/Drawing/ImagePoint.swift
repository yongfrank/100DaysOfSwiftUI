//
//  ImagePoint.swift
//  Drawing
//
//  Created by Frank Chu on 3/19/22.
//

import SwiftUI

struct ImagePoint: View {
    var body: some View {
        
        Capsule()
            .strokeBorder(ImagePaint(image: Image("XcodeZeldaBotW"), scale: 0.1), lineWidth: 20)
            .frame(width: 300, height: 200)


    }
}

struct ImagePoint_Previews: PreviewProvider {
    static var previews: some View {
        ImagePoint()
    }
}
