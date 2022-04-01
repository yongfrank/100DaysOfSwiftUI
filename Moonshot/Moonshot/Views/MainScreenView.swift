//
//  MainScreenView.swift
//  Moonshot
//
//  Created by Frank Chu on 3/17/22.
//

import SwiftUI

struct MainScreenView: View {
    
    @State private var showingGrid = true
    
    
    
    var body: some View {
        NavigationView {
            
            Group {
                if showingGrid {
                    GridLayout()
                } else {
                    ListLayout()
                }
            }
            
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                HStack {
                    Button {
                        showingGrid.toggle()
                    } label: {
                        showingGrid == true ? Image(systemName: "square.grid.2x2") : Image(systemName: "list.dash")
                    }
                    
                    
                }
            }
        }
        
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
            .preferredColorScheme(.dark)
    }
}