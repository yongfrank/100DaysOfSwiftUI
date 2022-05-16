//
//  integrating-core-image-with-swiftui.swift
//  Instafilter
//
//  Created by Frank Chu on 4/28/22.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct integrating_core_image_with_swiftui: View {
    @State private var image: Image?
    
    var body: some View {
        VStack {
            Image("Example")
                .resizable()
                .scaledToFit()
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
        
    }
    
    func loadImage() {
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
//        let currentFilter = CIFilter.sepiaTone()
//        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 1
//        
//        let currentFilter = CIFilter.pixellate()
//        currentFilter.inputImage = beginImage
//        currentFilter.scale = 50
        
        let currentFilter = CIFilter.crystallize()
        currentFilter.inputImage = beginImage
        currentFilter.radius = 200
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
            
    }
}

struct integrating_core_image_with_swiftui_Previews: PreviewProvider {
    static var previews: some View {
        integrating_core_image_with_swiftui()
    }
}
