//
//  ContentView.swift
//  ARTest
//
//  Created by Frank Chu on 5/1/22.
//

import SwiftUI
import RealityKit

let boxAnchor = try! Battery.loadScene()

struct ContentView : View {
    @State var isStarted = false
    
    @State var hi = false
    var body: some View {
        if !isStarted {
            StartedView(isStarted: $isStarted)
        } else {
            ZStack {
                StartARView(hi: $hi)
                Button {
                    hi.toggle()
                    boxAnchor.notifications.cylinder.post()
                } label: {
                    Text("Hi")
                        .background(hi == true ? .yellow : .blue)
                }
                .buttonStyle(.bordered)
                
            }
        }
    }
}



struct StartARView: View {
    @Binding var hi: Bool
    var body: some View {
        return ARViewContainer(hi: $hi).edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var hi: Bool
    
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        
        
        boxAnchor.actions.duckStarted.onAction = { _ in
            print("duck started")
//
        }
        
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
//    func pressButton(sender: Binding<Any>) {
//        boxAnchor.notifications.cylinder.post()
//    }
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
