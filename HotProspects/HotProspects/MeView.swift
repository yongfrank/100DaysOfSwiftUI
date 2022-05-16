//
//  MeView.swift
//  HotProspects
//
//  Created by Frank Chu on 5/13/22.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @State private var yourNameInput = "Anonymous"
    @State private var yourEmailAddressInput = "you@yoursite.com"
    @State private var qrCode = UIImage()

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $yourNameInput)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email Address", text: $yourEmailAddressInput)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
//                            let image = generateQRCode(from: "\(yourNameInput)\n\(yourEmailAddressInput)")
                            
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        } label: {
                            Label("Save to Photos", systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .onAppear(perform: updateCode)
            .onChange(of: yourNameInput) { _ in updateCode() }
            .onChange(of: yourEmailAddressInput) { _ in updateCode() }
            .navigationTitle("Your code")
        }
        
        
    }
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                qrCode = UIImage(cgImage: cgimg)
                return qrCode
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func updateCode() {
        qrCode = generateQRCode(from: "\(yourNameInput)\n\(yourEmailAddressInput)")
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
