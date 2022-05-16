//
//  ContentView.swift
//  SwiftUIPencilKit
//
//  Created by Frank Chu on 4/20/22.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    
    
    var body: some View {
        TabView {
            CanvasNewView()
                .tabItem({Image(systemName: "scribble.variable")})
            CanvasNewView()
            .tabItem({Image(systemName: "hammer")})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ScribbleVariable: View {
    
    @State var canvasCanBeSaved = PKCanvasView()
    @State var saveSuccessfullyAlert = false
    @State var toolPickerVisible = true
    
    
//    @Environment(\.undoManager) private var undoManager
    
    var body: some View {
        NavigationView {
            PencilKitView(pencilKitCanvasView: $canvasCanBeSaved, toolPickerVisible: $toolPickerVisible)
                .navigationTitle("Drawing")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        Button {
                            saveImage()
                        } label: {
                            Image(systemName: "square.and.arrow.down")
                        }
                    }
                    ToolbarItem {
                        Button {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: canvasCanBeSaved.drawing.image(from: canvasCanBeSaved.bounds, scale: 10))
                            saveSuccessfullyAlert.toggle()
                        } label: {
                            Text("UIKit")
                        }
                    }
                    ToolbarItem {
                        Button {
                            toolPickerVisible.toggle()
                        } label: {
                            Text("Tool Picker")
                        }
                    }
                    ToolbarItem {
                        Button {
                            canvasCanBeSaved.drawing = PKDrawing()
                        } label: {
                            Text("Clear")
                        }
                    }
                }
        }
        .alert("Save Successful", isPresented: $saveSuccessfullyAlert) {}
        .navigationViewStyle(.stack)
    }
    
    func saveImage() {
        let image = canvasCanBeSaved.drawing.image(from: canvasCanBeSaved.bounds, scale: 5)
//        canvasCanBeSaved.drawing.bounds
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        saveSuccessfullyAlert.toggle()
    }
}

struct PencilKitView: UIViewRepresentable {
    @Binding var pencilKitCanvasView: PKCanvasView
    @Binding var toolPickerVisible: Bool
    let toolPicker = PKToolPicker()
    
    func makeUIView(context: Context) -> some UIView {
//        let pencilKitCanvasView = PKCanvasView()
        
        
        pencilKitCanvasView.drawingPolicy = .anyInput
        toolPicker.addObserver(pencilKitCanvasView)
        toolPicker.setVisible(true, forFirstResponder: pencilKitCanvasView)
        
//        canvasView.tool = PKInkingTool(.pen, color: .black, width: 15)
        
//        toolPicker.setVisible(true, forFirstResponder: toolPickerVisible)
        pencilKitCanvasView.becomeFirstResponder()
        
        return pencilKitCanvasView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        toolPicker.setVisible(toolPickerVisible, forFirstResponder: uiView)
    }
}
