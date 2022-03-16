//
//  AnimalImage.swift
//  Edutainment
//
//  Created by Frank Chu on 3/14/22.
//

import SwiftUI

struct AnimalImage: View {
    var image: Image
    
    var body: some View {
        image
//            .resizable()
            .shadow(radius: 7)
//            .aspectRatio(contentMode: .fit)
        
    }
}

struct AnimalsSet_Previews: PreviewProvider {
    static var previews: some View {
        AnimalImage(image: Image("crocodile"))
    }
}
