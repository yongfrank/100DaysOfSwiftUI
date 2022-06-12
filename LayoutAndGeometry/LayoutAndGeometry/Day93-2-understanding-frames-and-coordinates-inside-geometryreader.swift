//
//  Day93-2-understanding-frames-and-coordinates-inside-geometryreader.swift
//  LayoutAndGeometry
//
//  Created by Frank Chu on 6/1/22.
//

import SwiftUI

struct Day93_2_understanding_frames_and_coordinates_inside_geometryreader: View {
    var body: some View {
//        VStack {
//            GeometryReader { geo in
//                Text("Hello, World!")
//                    .frame(width: geo.size.width * 0.9)
//                    .background(.red)
//            }
//            Text("More text")
//                .background(.blue)
//        }
        
//        Text("HI")
        OuterView()
            .background(.red)
//            .coordinateSpace(name: "Custom")
    }
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.yellow)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            
            GeometryReader { geo in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global))")
                        print("Global center: \(geo.frame(in: .global).maxX)")
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                    }
            }
            .background(.orange)
            Text("Right")
        }
    }
}

struct Day93_2_understanding_frames_and_coordinates_inside_geometryreader_Previews: PreviewProvider {
    static var previews: some View {
        Day93_2_understanding_frames_and_coordinates_inside_geometryreader()
    }
}
