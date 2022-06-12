//
//  Day93-3-scrollview-effects-using-geometryreader.swift
//  LayoutAndGeometry
//
//  Created by Frank Chu on 6/4/22.
//

import SwiftUI

struct Day93_3_scrollview_effects_using_geometryreader: View {
    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink]
    
    var body: some View {
        ScrollView {
            ForEach(0..<50) { index in
                GeometryReader { geo in
                    Text("Row \(index)")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .background(colors[index % 7])
                        .rotation3DEffect(.degrees(geo.frame(in: .global).minY / 5), axis: (x: 0, y: 1, z: 0))
                }
                .frame(height: 40)
            }
        }
    }
}

struct Day93_3_scrollview_effects_using_geometryreader_Previews: PreviewProvider {
    static var previews: some View {
        Day93_3_scrollview_effects_using_geometryreader()
    }
}
