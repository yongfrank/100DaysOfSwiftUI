//
//  LoadingRemoteImage.swift
//  CupcakeCorner
//
//  Created by Frank Chu on 4/1/22.
//  https://www.hackingwithswift.com/books/ios-swiftui/loading-an-image-from-a-remote-server

import SwiftUI

struct LoadingRemoteImage: View {
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)

            AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error loading the image.")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 200, height: 200)

        }
    }
}

struct LoadingRemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        LoadingRemoteImage()
    }
}
