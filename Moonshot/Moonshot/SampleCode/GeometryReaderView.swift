//
//  GeometryReaderView.swift
//  Moonshot
//
//  Created by Frank Chu on 3/17/22.
//  https://www.hackingwithswift.com/books/ios-swiftui/resizing-images-to-fit-the-screen-using-geometryreader



import SwiftUI

struct GeometryReaderView: View {
    var body: some View {
        GeometryReader { geo in
            Image("ZeldaBotW")
                .resizable()
                .scaledToFit()
//                    .scaledToFill()
                .frame(width: geo.size.width * 0.8)
                .frame(width: geo.size.width, height: geo.size.height)
        }
    //            .clipped()
        
        
    }
}

struct GeometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView()
    }
}
