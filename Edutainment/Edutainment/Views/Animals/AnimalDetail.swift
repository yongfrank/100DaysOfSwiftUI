//
//  AnimalDetail.swift
//  Edutainment
//
//  Created by Frank Chu on 3/14/22.
//

import SwiftUI

struct AnimalDetail: View {
    var animal: Animal
    
    var body: some View {
        ScrollView {
            Image("farm")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            
            AnimalImage(image: animal.image)
                .offset(y: -60)
                .padding(.bottom, -60)
            
            VStack(alignment: .leading) {
                Text(animal.name.capitalized)
                    .font(.title)
                
                HStack {
                    Text("Animal Farm")
                    Spacer()
                    Text("Hangzhou")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("About \(animal.name.capitalized)")
                    .font(.title2)
                Text(description)
            }
            .padding()
            
        }
        .navigationTitle(animal.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AnimalDetail_Previews: PreviewProvider {
    static var previews: some View {
        AnimalDetail(animal: animals[0])
    }
}
