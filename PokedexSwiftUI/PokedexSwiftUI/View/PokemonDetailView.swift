//
//  PokemonDetailView.swift
//  PokedexSwiftUI
//
//  Created by Frank Chu on 6/11/22.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    
    let pokemon: Pokemon
//    let viewModel: PokemonViewModel
//
//    init(pokemon: Pokemon, viewModel: PokemonViewModel) {
//        self.pokemon = pokemon
//        self.viewModel = viewModel
//    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient:
                    Gradient(colors: [
                        Color(bgColor(forType: pokemon.type)),
                        .white
                    ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            Color.white.offset(y: 300)
            
            ScrollView {
                KFImage(URL(string: pokemon.imageUrl))
                    .resizable()
                    .frame(width: 200, height: 200)
                
                
                VStack {
                    AsyncImage(url: URL(string: pokemon.imageUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                        .frame(width: 200, height: 200)
                    AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.red
                    }
                    .frame(width: 200, height: 200)
                    
                    Text(pokemon.name.capitalized)
                        .font(.largeTitle)
                        .padding(.top, 40)
                    
                    Text(pokemon.type.capitalized)
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 24)
                        .background(Color(bgColor(forType: pokemon.type)))
                        .clipShape(Capsule())
                    
                    
                    Text(pokemon.description)
                        .padding(.top, 12)
                    Divider()
                    
                    HStack {
                        Text("Stats").bold()
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .background(.white)
                .cornerRadius(40)
                .padding(.top, -40)
                .zIndex(-1)
            }
            
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: MOCK_POKEMON[0])
    }
}
