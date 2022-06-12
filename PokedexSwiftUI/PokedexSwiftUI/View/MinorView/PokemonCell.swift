//
//  PokemonCell.swift
//  PokedexSwiftUI
//
//  Created by Frank Chu on 6/11/22.
//

import SwiftUI
import Kingfisher

struct PokemonCell: View {
    let pokemon: Pokemon
    let viewModel: PokemonViewModel
    let colorDiff: Color
    
    init(pokemon: Pokemon, viewModel: PokemonViewModel) {
        self.pokemon = pokemon
        self.viewModel = viewModel
        self.colorDiff = Color(viewModel.backgroundColor(forType: pokemon.type))
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text(pokemon.name.capitalized)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 8)
                    .padding(.leading)
                
                HStack {
                    Text(pokemon.type)
                        .font(.subheadline)
                        .foregroundColor(.white).bold()
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.25))
                                
                        }
                        .frame(width: 100, height: 24)
                    
                    KFImage(URL(string: pokemon.imageUrl))
                        .resizable()
                        .scaledToFit()
                        .padding([.bottom, .trailing], 4)
                        .frame(width: 68, height: 68)
                }
            }
        }
        .background(colorDiff)
        .cornerRadius(12)
        .shadow(color: colorDiff, radius: 6)
    }
    
}

struct PokemonCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            // https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation
            PokemonCell(pokemon: MOCK_POKEMON[0], viewModel: PokemonViewModel())
                .previewLayout(.fixed(width: 300, height: 70))
            PokemonCell(pokemon: MOCK_POKEMON[0], viewModel: PokemonViewModel())
                .previewLayout(.fixed(width: 300, height: 70))
        }
    }
}
