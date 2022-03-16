//
//  AnimalList.swift
//  Edutainment
//
//  Created by Frank Chu on 3/14/22.
//

import SwiftUI

struct AnimalList: View {
    var body: some View {
        NavigationView {
            List(animals) { animal in
                NavigationLink {
                    AnimalDetail(animal: animal)
                } label: {
                    AnimalRow(animal: animal)
                }
            }
            .navigationTitle("Animal Farm")
        }
    }
}

struct AnimalList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone 12", "iPod touch (7th generation)"], id: \.self) { displayName in
            AnimalList()
                .previewDevice(PreviewDevice(rawValue: displayName))
                .previewDisplayName(displayName)
        }
        
//        AnimalList()
    }
}
