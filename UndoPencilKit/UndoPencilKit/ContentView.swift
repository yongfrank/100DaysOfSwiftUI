//
//  ContentView.swift
//  UndoPencilKit
//
//  Created by Frank Chu on 4/21/22.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    @Environment(\.undoManager) private var undoManager
    @State private var canvasView = PKCanvasView()

        var body: some View {
            VStack(spacing: 10) {
                Button("Clear") {
                    canvasView.drawing = PKDrawing()
                }
                Button("Undo") {
                    undoManager?.undo()
                }
                Button("Redo") {
                    undoManager?.redo()
                }
                MyCanvas(canvasView: $canvasView)
            }
        }
    
}

struct MyCanvas: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    let toolPicker = PKToolPicker()

    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
//        canvasView.tool = PKInkingTool(.pen, color: .blue, width: 15)
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
//        canvasView.becomeFirstResponder()
        
        return canvasView
    }

    func updateUIView(_ canvasView: PKCanvasView, context: Context) { }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
