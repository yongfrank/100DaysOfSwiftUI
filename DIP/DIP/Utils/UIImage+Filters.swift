//
//  UIImage+Filters.swift
//  DIP
//
//  Created by Frank Chu on 10/8/22.
//

import SwiftUI

// import CoreImage
// CIFilterBuiltins is for CIFilter.sepiaTone()
import CoreImage.CIFilterBuiltins

struct UIImage_Filters_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Image(uiImage:
                    UIImage(imageLiteralResourceName: ImageAssets.EXAMPLE.name)
            )
            .smaller(isSizeFixed: false)
            Image(uiImage:
                    UIImage(imageLiteralResourceName: ImageAssets.EXAMPLE.name).sharpeningImage()
            )
            .smaller(isSizeFixed: false)
        }
    }
}

extension UIImage {
    func increaseContrast() -> UIImage {
        
        //  We need two properties to store an active Core Image context
        let context = CIContext()
        let uiImage = self
        
        if let inputImage: CIImage = CIImage(image: uiImage) {
            let parameters = [
                "inputContrast": NSNumber(value: 50)
            ]
            /* A convenience method for applying a filter to an image.
             * The method returns outputImage of the filter after setting the
             * filter's inputImage to the method receiver and other parameters
             * from the key/value pairs of 'parameters'. */
            /// `@available(iOS 8.0, *)`
            /// `open func applyingFilter(_ filterName: String, parameters params: [String : Any]) -> CIImage`
            /// get a CIImage from our filter or exit if that fails
            let outputImage: CIImage = inputImage.applyingFilter("CIColorControls", parameters: parameters)
            
            /// /* Return a rect the defines the bounds of non-(0,0,0,0) pixels */
            /// `open var extent: CGRect { get }`
            /// Summary
            /// Creates a Quartz 2D image from a region of a Core Image image object.
            /// attempt to get a CGImage from our CIImage
            if let img: CGImage = context.createCGImage(outputImage, from: outputImage.extent) {
                // convert that to a UIImage
                return UIImage(cgImage: img)
            }
        }
        //  If conversion fails for any reason
        //  we’ll send back the “xmark.circle” image from SF Symbols.
        //  If that can’t be read – which is theoretically possible
        //  because SF Symbols is stringly typed – then we’ll send back an empty UIImage.
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    /// Swift core image apply sharpen to image without CIFilter
    ///
    /// https://stackoverflow.com/questions/56865536/swift-core-image-apply-sharpen-to-image-without-cifilter
    func sharpeningImage() -> UIImage {
        let inputImage: UIImage = self
        let beginImage: CIImage? = CIImage(image: inputImage)
        
        let context: CIContext = CIContext()
        guard let currentFilter: CIFilter = CIFilter(name: "CIUnsharpMask") else {
            return UIImage(systemName: "xmark.circle") ?? UIImage()
        }
        
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(2.0, forKey: "inputIntensity")
        currentFilter.setValue(1.0, forKey: "inputRadius")
        
        guard let outputImage: CIImage = currentFilter.outputImage else {
            return UIImage(systemName: "xmark.circle") ?? UIImage()
        }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            return uiImage
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    /// Integrating Core Image with SwiftUI
    ///
    /// https://www.hackingwithswift.com/books/ios-swiftui/integrating-core-image-with-swiftui
    func sepiaToneFilter() -> UIImage {
        let inputImage: UIImage = self
        let beginImage: CIImage? = CIImage(image: inputImage)
        
        /// Next we'll create the context and filter.
        /// For this example we're going to use a sepia tone filter,
        /// which appliees a brown tone that makes a photo look like it was taken a long time age.
        let context: CIContext = CIContext()
        let currentFilter: CIFilter & CISepiaTone = CIFilter.sepiaTone()
        
        /// Sepia is a simple filter, so it only has two interesting properties:
        /// `inputImage` is the image we want to change, and `intensity` is how strongly
        /// the sepia effect should be applied, specified in the range 0 (original image) and 1 (full sepia).
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1
        
        /// get a CIImage from our filter or exit if that fails
        guard let outputImage: CIImage = currentFilter.outputImage else { return UIImage(systemName: "xmark.circle") ?? UIImage() }
        
        /// attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)
            return uiImage
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
