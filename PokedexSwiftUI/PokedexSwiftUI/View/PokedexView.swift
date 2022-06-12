//
//  PokedexView.swift
//  PokedexSwiftUI
//
//  Created by Frank Chu on 6/11/22.
//

import SwiftUI

struct PokedexView: View {
    
    @ObservedObject var viewModel = PokemonViewModel()
    @ObservedObject var settings = SystemSettings()
    
    var gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        let dataSource = settings.filteredApplied ? viewModel.filteredPokemon : viewModel.pokemons
                        
                        ForEach(dataSource) { pokemon in
                            
                            NavigationLink {
                                PokemonDetailView(pokemon: pokemon)
                            } label: {
                                PokemonCell(pokemon: pokemon, viewModel: viewModel)
                            }
                        }
                    }
                }
                .navigationTitle("Pokedex")
                
                FilteredView(settings: settings, viewModel: viewModel)
            }
        }
    }
    
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
