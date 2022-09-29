//
//  ContentView.swift
//  HelloTriangle
//
//  Created by Frank Chu on 9/29/22.
//

import SwiftUI
import MetalKit

struct ContentView: UIViewRepresentable {
    
    typealias UIViewType = MTKView
    
    func makeCoordinator() -> Renderer {
        Renderer(parent: self)
    }
    
    func makeUIView(context: Context) -> MTKView {
        let mtkView = MTKView()
        
        /// The next step is to tell the `MTKView`
        /// that when something happens it should tell our coordinator.
        /// That code won’t compile,
        /// but before we fix it I want to spend just a moment digging in to what just happened.
        ///
        /// The reason our code doesn't compile is that Swift is checking
        /// that our coordinator class is *capable* of acting as
        /// a delegate for ** MTKView **, finding that it isn't,
        /// and so is refusing to build our code any further.
        /// To fix this we need to modify our ** Coordinator / Renderer ** class.
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        mtkView.enableSetNeedsDisplay = true
        
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            mtkView.device = metalDevice
        }
        
        mtkView.framebufferOnly = false
        mtkView.drawableSize = mtkView.frame.size
        
        return mtkView
    }
    
    func updateUIView(_ uiView: MTKView, context: Context) {
        
    }
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

class Renderer: MTKViewDelegate {
    
    var parent: ContentView
    
    init(parent: ContentView) {
        self.parent = parent
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
