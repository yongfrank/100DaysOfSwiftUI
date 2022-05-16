//
//  DrawingWrapper.swift
//  DrawingDocApp
//
//  Created by Frank Chu on 4/14/22.
//

import Foundation
import SwiftUI
import PencilKit


struct DrawingWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = PKCanvasView
    
    var manager: DrawingManager
    var id: UUID
    var hi: Int
    func makeUIViewController(context: Context) -> PKCanvasView {
        let viewController = PKCanvasView()
        viewController.drawingData = manager.getData(for: id)
        viewController.drawingChanged = { data in
            manager.update(data: data, for: id)
        }
        return viewController
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        uiViewController.drawingData = manager.getData(for: id)
    }
}

extension PKCanvasView {
    var drawingData: Data { get{} set{} }
    var drawingChanged: (Data) -> Void {
        get { return { _ in } }
        set {  }
    }
}
