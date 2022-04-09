//
//  MemeCreator.swift
//  memeCreator
//
//  Created by Frank Chu on 4/7/22.
//

import SwiftUI

struct MemeCreator: View {
    @EnvironmentObject var fetcher: PandaCollectionFetcher
    
    
    var body: some View {
        VStack {
            Spacer()
            LoadableImage(imageMetadataByFrank: fetcher.currentPanda)
            
            Spacer()
            
            HStack {
                Button {
                    if let randomImage = fetcher.imageData.sample.randomElement() {
                        fetcher.currentPanda = randomImage
                    }
                } label: {
                    VStack {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.largeTitle)
                            .padding(.bottom, 4)
                        Text("Shuffle Photo")
                    }
                    .frame(maxWidth: 180, maxHeight: .infinity)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
        }
        .navigationTitle("Meme Creator")
    }
}
