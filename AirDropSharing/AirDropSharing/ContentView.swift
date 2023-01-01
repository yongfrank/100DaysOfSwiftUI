//
//  ContentView.swift
//  AirDropSharing
//
//  Created by Frank Chu on 8/26/22.
//

import SwiftUI


struct ContentView: View {
    let pokeCards: PokeCards = AssetLoader.loadWithDecode(name: "cards")
    var body: some View {
        VStack {
            Text(pokeCards.data.first?.name ?? "None")
            AsyncImage(url: pokeCards.data.first?.images.largeImageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.red
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


