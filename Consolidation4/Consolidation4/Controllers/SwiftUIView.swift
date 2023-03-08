//
//  SwiftUIView.swift
//  Consolidation4
//
//  Created by Frank Chu on 2/9/23.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var isStopped = false
    @State private var textFieldStr = ""
    var body: some View {
//        Text("hello world")
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            VStack {
                
                MyProgressView(isStop: isStopped)
                    .border(.blue)
                Button("Start / Stop") {
                    self.isStopped.toggle()
                }
                TextField("write down", text: $textFieldStr)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    
            }
        }
    }
}

struct MyProgressView: UIViewRepresentable {
    var isStop: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        view.stopAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if isStop {
            uiView.stopAnimating()
            uiView.hidesWhenStopped = false
        } else {
            uiView.startAnimating()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        
    }
    
    typealias UIViewType = UIActivityIndicatorView
    
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
