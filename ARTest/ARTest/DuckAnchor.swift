//
//  DuckAnchor.swift
//  ARTest
//
//  Created by Frank Chu on 5/3/22.
//

import SwiftUI
import RealityKit

let duckDuck = try! AnchorDuck.loadScene()

struct DuckAnchor: View {
    var body: some View {
        ContainerOfAR()
    }
}

struct ContainerOfAR: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let arView = ARView(frame: .zero)
        
        arView.scene.anchors.append(duckDuck)
        
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct DuckAnchor_Previews: PreviewProvider {
    static var previews: some View {
        DuckAnchor()
    }
}
