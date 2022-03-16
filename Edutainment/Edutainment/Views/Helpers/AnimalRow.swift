//
//  AnimalRow.swift
//  Edutainment
//
//  Created by Frank Chu on 3/14/22.
//

import SwiftUI

struct AnimalRow: View {
    var animal: Animal
    
    var body: some View {
        HStack {
//            AnimalImage(image: animal.image)
            animal.image
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Text(animal.name)
            
            Spacer()
        }
    }
}

struct AnimalRow_Previews: PreviewProvider {
//    static var animals = animals
    
    static var previews: some View {
//        AnimalRow(animal: animals[0])
        Group {
            AnimalRow(animal: animals[0])
            AnimalRow(animal: animals[1])
        }
        .previewLayout(.fixed(width: 400, height: 200))
        
    }
}
