//
//  Day92-2-alignment-and-alignment-guides.swift
//  LayoutAndGeometry
//
//  Created by Frank Chu on 5/27/22.
//

import SwiftUI

struct Day92_2_alignment_and_alignment_guides: View {
    var body: some View {
        
//        Text("hi")
//            .background(.red)
//            .padding()
//            .background(.yellow)
//        ZStack {
//            Color.red
//            Text("HI")
//        }
//        Text("Hello, World! 🥳 I'm Frank~~")
//            .frame(width: 300, height: 300, alignment: .topLeading)
//            .offset(y: -50)
//        HStack(alignment: .lastTextBaseline) {
//            Text("Live")
//                .font(.caption)
//            Text("long")
//            Text("and")
//                .font(.title)
//            Text("prosper")
//                .font(.largeTitle)
//        }
        
//        VStack(alignment: .leading) {
//            Text("Hello world")
//                .alignmentGuide(.leading) { d in
//                    d[.trailing]
//                }
//            Text("This is a longer line of text")
//        }
//        .background(.red)
//        .frame(width: 400, height: 400)
//        .background(.blue)
        VStack(alignment: .leading) {
            ForEach(0..<25) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in
                        CGFloat(position) * 10
                    }
            }
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
    }
}

struct Day92_2_alignment_and_alignment_guides_Previews: PreviewProvider {
    static var previews: some View {
        Day92_2_alignment_and_alignment_guides()
    }
}
