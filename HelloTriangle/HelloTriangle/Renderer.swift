//
//  Renderer.swift
//  HelloTriangle
//
//  Created by Frank Chu on 10/1/22.
//

import Foundation
import MetalKit

/// However, we hit a problem. To solve the problem of that
/// we weren’t able to respond to the user's input.
/// To make that happens requires a wholly new concept: coordinators.
///
/// class inherit from `NSObject`
/// the photo picker can say things like
/// “hey, the user selected an image, what do you want to do?
///
/// `MTKViewDelegate`
/// adds functionality for detecting when the user selects an image.
/// (NSObject lets Objective-C check for the functionality;
/// this protocol is what actually provides it.)
class Renderer: NSObject, MTKViewDelegate {
    
    var parent: MetalStruct
    
    /// @protocol MTLDevice
    /// @abstract MTLDevice represents a processor capable of data parallel computations
    var metalDevice: MTLDevice!
    
    /// @protocol MTLCommandQueue
    /// @brief A serial queue of command buffers to be executed by the device.
    var metalCommandQueue: MTLCommandQueue!
    
    let vertexBuffer: MTLBuffer
    
    /// `public protocol MTLRenderPipelineState : NSObjectProtocol { }`
    let pipelineState: MTLRenderPipelineState
    
    init(parent: MetalStruct) {
        self.parent = parent
        
        /// @brief Returns a reference to the preferred system default Metal device.
        /// @discussion On Mac OS X systems that support automatic graphics switching, calling
        /// this API to get a Metal device will cause the system to switch to the high power
        /// GPU.  On other systems that support more than one GPU it will return the GPU that
        /// is associated with the main display.
        ///
        /// `public func MTLCreateSystemDefaultDevice() -> MTLDevice?`
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            self.metalDevice = metalDevice
        }
        
        /*!
         @method newCommandQueue
         @brief Create and return a new command queue.   Command Queues created via this method will only allow up to 64 non-completed command buffers.
         @return The new command queue object
         */
        /// `- (nullable id <MTLCommandQueue>)newCommandQueue;`
        self.metalCommandQueue = metalDevice.makeCommandQueue()
        
        /// `open class MTLRenderPipelineDescriptor : NSObject, NSCopying { }`
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        
        /// `let library: MTLLibrary?`
        let library = metalDevice.makeDefaultLibrary()
        
        pipelineDescriptor.vertexFunction = library?.makeFunction(name: "vertexShader")
        pipelineDescriptor.fragmentFunction = library?.makeFunction(name: "fragmentShader")
        
        /// `public enum MTLPixelFormat : UInt, @unchecked Sendable { }`
        /// BGRA order
        /// https://community.khronos.org/t/rgba-or-bgra/15682
        /// RGBA or BGRA ?
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        do {
            try pipelineState = metalDevice.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            /// Unconditionally prints a given message and stops execution.
            fatalError()
        }
        let vertices: [Vertex] = [
            Vertex(position: [-1, -1], color: [1, 0, 0, 1]),
            Vertex(position: [1, -1], color: [0, 1, 0, 1]),
            Vertex(position: [0, 1], color: [0, 0, 1, 1])
        ]
        self.vertexBuffer = metalDevice.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Vertex>.stride, options: [])!
//        super.init()
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        
        /// ```swift
        /// open class MTKView : UIView, NSCoding, CALayerDelegate {
        ///     open var currentDrawable: CAMetalDrawable? { get }
        /// }
        /// ```
        /// The Drawable to be used for the current frame.
        /// Core Animation
        guard let drawable: CAMetalDrawable = view.currentDrawable else {
            return
        }
        
        /// ```swift
        /// @available(iOS 9.0, *)
        /// open class MTKView : UIView, NSCoding, CALayerDelegate {
        ///     open var currentRenderPassDescriptor: MTLRenderPassDescriptor? { get }
        /// }
        /// ```
        /// A render pass descriptor genetated from the current drawable's texture and the view's depth, stencil, and sample buffers and clear values.
        let renderPassDescriptor: MTLRenderPassDescriptor? = view.currentRenderPassDescriptor
        
        /// The clear color to be used if the loadAction property is MTLLoadActionClear
        /// `var clearColor: MTLClearColor { get set }
        renderPassDescriptor?.colorAttachments[0].clearColor = MTLClearColorMake(0, 0.5, 0.5, 1.0)
        renderPassDescriptor?.colorAttachments[0].loadAction = .clear
        renderPassDescriptor?.colorAttachments[0].storeAction = .store
        
        let commandBuffer: MTLCommandBuffer? = self.metalCommandQueue.makeCommandBuffer()
        
        let renderEncoder: MTLRenderCommandEncoder? = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor!)
        
        renderEncoder?.setRenderPipelineState(pipelineState)
        /// Set a global buffer for all vertex shaders at the given bind point index
        renderEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        /// Encodes a command to render one instance of primitives using vertex data in contiguous array elements.
        renderEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
        
        /// Declares that all command generation from the encoder is completed.
        renderEncoder?.endEncoding()
        
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}

