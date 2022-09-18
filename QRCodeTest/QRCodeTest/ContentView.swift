//
//  ContentView.swift
//  QRCodeTest
//
//  Created by Frank Chu on 9/15/22.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import Kingfisher

struct ContentView: View {
    @State private var textToQRCode: String = "apple.com"
    
    var body: some View {
        VStack {
            TextField("Input something to generate QRCode", text: $textToQRCode)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
            Image(uiImage: QRCodeManager.shared.generateQRCode(from: textToQRCode))
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 300, height: 300)
            KFImage(ImageInfomation.EXAMPLE.url)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 400)
                .border(.blue)
                .clipped()
        }
        .padding()
    }
}

struct ImageInfomation {
    let name: String
    let urlString: String
    var url: URL? {
        URL(string: self.urlString)
    }
    
    static let EXAMPLE: ImageInfomation = .init(name: "Apple", urlString: "https://docs-assets.developer.apple.com/published/9171798f66624fb18c9f216d85d85ad3/SwiftUI-FIIAS-Landscape_4-original.jpg")
}

class QRCodeManager {
    
    static let shared = QRCodeManager()
    
    let imgApple: String = "https://docs-assets.developer.apple.com/published/9171798f66624fb18c9f216d85d85ad3/SwiftUI-FIIAS-Landscape_4-original.jpg"
    
    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
