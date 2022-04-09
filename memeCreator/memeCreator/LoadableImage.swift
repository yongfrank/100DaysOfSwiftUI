//
//  LoadableImage.swift
//  memeCreator
//
//  Created by Frank Chu on 4/7/22.
//

import SwiftUI

struct LoadableImage: View {
    
    var imageMetadataByFrank: Panda
    
    
    var body: some View {
        AsyncImage(url: imageMetadataByFrank.imageUrl) { phaseTemp in
            if let image = phaseTemp.image {
                image
                
            } else if phaseTemp.error != nil {
                VStack {
                    Image("pandaplaceholder")
                    
                    Text("The pandas were all busy.")
                        .font(.title2)
                    Text("Please try again.")
                        .font(.title3)
                }
            } else {
                ProgressView()
            }
        }
    }
}

struct LoadableImage_Previews: PreviewProvider {
    static var previews: some View {
        LoadableImage(imageMetadataByFrank: Panda.defaultPanda)
    }
}
