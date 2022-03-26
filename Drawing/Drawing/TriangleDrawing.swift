//
//  TriangleDrawing.swift
//  Drawing
//
//  Created by Frank Chu on 3/19/22.
//

import SwiftUI

struct TriangleDrawing: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
//            path.closeSubpath()
        }
        .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
    }
}

struct TriangleDrawing_Previews: PreviewProvider {
    static var previews: some View {
        TriangleDrawing()
    }
}
