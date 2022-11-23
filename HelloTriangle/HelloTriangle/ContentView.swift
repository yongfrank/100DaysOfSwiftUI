//
//  ContentView.swift
//  HelloTriangle
//
//  Created by Frank Chu on 9/29/22.
//

import SwiftUI
import MetalKit

struct ContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            MetalStruct()
                .frame(width: 350, height: 350)
        }
        .padding()
    }
}


/// Wrapping a UIKit view controller requires us to create a struct
/// that conforms to the `UIViewRepresentable` protocol.
///
/// That protocol builds on View, which means the struct we’re defining can be used inside a SwiftUI view hierarchy,
/// however we don’t provide a body property
/// because the view’s body is the view controller itself –
/// it just shows whatever UIKit sends back.
struct MetalStruct: UIViewRepresentable {
    
    /// These methods have really precise signatures,
    /// so I’m going to show you a neat shortcut.
    /// The reason the methods are long is because SwiftUI needs to know
    /// what type of view controller our struct is wrapping,
    /// so if we just straight up tell Swift that type Xcode will help us do the rest.
    ///
    /// That isn’t enough code to compile correctly,
    /// but when Xcode shows an error saying “Type ImagePicker does not conform to
    /// protocol `UIViewControllerRepresentable`”,
    /// please click the red and white circle to the left of the error and select “Fix”.
    /// This will make Xcode write the two methods we actually need,
    /// and in fact those methods are actually enough for Swift to figure out
    /// the view controller type so you can delete the typealias line.
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
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
