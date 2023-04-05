//
//  SwiftUIView.swift
//  Project10NameToFaces
//
//  Created by Frank Chu on 2/12/23.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack {
            Text("Hello")
            UIKitView()
            //            CollectionView()
            AlertView()
        }
    }
}

struct UIKitView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
    
    typealias UIViewType = UIActivityIndicatorView
    
    
}

struct AlertView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIAlertController {
        let ac = UIAlertController(title: "Alert", message: "This is a alert.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Go", style: .cancel, handler: { _ in
            
        }))
//        context.coordinator
        return ac
    }
    
    func updateUIViewController(_ uiViewController: UIAlertController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator {
        var parent: AlertView
        
        init(parent: AlertView) {
            self.parent = parent
        }
    }
    
    typealias UIViewControllerType = UIAlertController
    
}

struct CollectionView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UICollectionViewController {
        let controller = UICollectionViewController(nibName: "Collection", bundle: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UICollectionViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UICollectionViewController
    
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
