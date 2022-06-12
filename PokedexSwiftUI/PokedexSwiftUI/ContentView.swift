//
//  ContentView.swift
//  PokedexSwiftUI
//
//  Created by Frank Chu on 6/11/22.
//

import Kingfisher
import SwiftUI

struct ContentView: View {
    let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2F2CF15848-AAF9-49C0-90E4-28DC78F60A78?alt=media&token=15ecd49b-89ff-46d6-be0f-1812c948e334")

    var body: some View {
        ScrollView {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            KFImage(url!)

            LazyVGrid(columns:
                [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ])
            {
                ForEach(0 ..< 10) { _ in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray.opacity(0.4))
                            .frame(height: 100)
                        KFImage(url)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
