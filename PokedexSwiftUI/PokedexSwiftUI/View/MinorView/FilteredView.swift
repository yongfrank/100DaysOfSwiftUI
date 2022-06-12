//
//  FilteredView.swift
//  PokedexSwiftUI
//
//  Created by Frank Chu on 6/11/22.
//

import SwiftUI

struct FilteredView: View {
    @ObservedObject var settings: SystemSettings
//    @State var showFilterButton = true
//    @State var filteredApplied = false
    
    @ObservedObject var viewModel: PokemonViewModel
    
    let filteredTypes = ["fire", "poison", "water", "electric"]
    var body: some View {
        VStack {
            if settings.showFilterButton {
                VStack {
                    ForEach(filteredTypes, id: \.self) { type in
                        TypeFilteredButtonView(
                            imgName: type,
                            backgroundColor: Color(viewModel.backgroundColor(forType: type))
                        ) {
                            settings.filteredApplied = true
                            settings.showFilterButton.toggle()
                            viewModel.filterPokemon(by: type)
                        }
                    }
                }
            }
            TypeFilteredButtonView (
                imgName: settings.filteredApplied ? "refresh" : "filter",
                height: 36, width: 36
            ) {
                settings.filteredApplied ? settings.filteredApplied.toggle() : settings.showFilterButton.toggle()
//                settings.showFilterButton.toggle()
            }
            .rotationEffect(.degrees(settings.showFilterButton ? 180 : 0))
        }
        .padding()
        .animation(.spring(), value: settings.showFilterButton ? 45.0 : 0.0)
    }
}

struct FilteredView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredView(settings: SystemSettings(), viewModel: PokemonViewModel())
    }
}
