//
//  ContentView.swift
//  ModelPickerApp
//
//  Created by Frank Chu on 4/23/22.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    
    var models: [String] = ["fender_stratocaster", "teapot", "toy_biplane", "toy_robot_vintage"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(0 ..< models.count, id: \.self) { index in
                        Button {
                            print("DEBUG: selected model with name: \(self.models[index])")
                        } label: {
                            Image(models[index])
//                            Image(uiImage: UIImage(named: models[index])!)
                        }
                    }
                }
            }
            .padding()
            .background(.black.opacity(0.5))
            
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
