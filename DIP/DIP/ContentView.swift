//
//  ContentView.swift
//  DIP
//
//  Created by Frank Chu on 10/8/22.
//

import SwiftUI

struct ImageAssets {
    var name: String
    
    static let EXAMPLE: ImageAssets = .init(name: "Lenna")
}

struct ContentView: View {
    let imageName: String = ImageAssets.EXAMPLE.name
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Image(
                uiImage: UIImage(imageLiteralResourceName: imageName)
            )
            .smaller()
            Image(
                uiImage:
                    UIImage(imageLiteralResourceName: imageName)
                    .sharpeningImage()
            )
            .smaller()
            Image(
                uiImage:
                    UIImage(imageLiteralResourceName: imageName)
                    .sepiaToneFilter()
            )
            .smaller()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class DIPFunction {
    static let shared = DIPFunction()
    func increaseContrast(_ uiImage: UIImage) -> UIImage {
        
        //  We need two properties to store an active Core Image context
        let context = CIContext()
        
        let inputImage = CIImage(image: uiImage)!
        let parameters = [
            "inputContrast": NSNumber(value: 10)
        ]
        
        /* A convenience method for applying a filter to an image.
         * The method returns outputImage of the filter after setting the
         * filter's inputImage to the method receiver and other parameters
         * from the key/value pairs of 'parameters'. */
        /// `@available(iOS 8.0, *)`
        /// `open func applyingFilter(_ filterName: String, parameters params: [String : Any]) -> CIImage`
        let outputImage: CIImage = inputImage.applyingFilter("CIColorControls", parameters: parameters)
        
        let img = context.createCGImage(outputImage, from: outputImage.extent)!
        
        return UIImage(cgImage: img)
    }
}
