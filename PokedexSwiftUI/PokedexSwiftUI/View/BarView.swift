//
//  BarView.swift
//  PokedexSwiftUI
//
//  Created by Frank Chu on 6/11/22.
//

import SwiftUI

class Out {
    var name: String
    var score: Int
    init(name: String, score: Int) {
        self.name = name
        self.score = score
    }
}

struct BarView: View {
    
    let pokemon: Pokemon
//    let stats = ["height", "attack", "defense", "weight"]
//
//    var out = [Out]()
    
    var body: some View {
        VStack {
            HStack {
                Text("Height: ")
                Text("\(pokemon.height)")
                
                ZStack {
                    Capsule()
                        .frame(width: 180, height: 20)
                        .foregroundColor(Color(.systemGray5))
                    
                    Capsule()
                        .frame(width: 180, height: 20)
                }
            }
        }
        
    }
    
//    mutating func filteredValus(i: Pokemon, j: [String]) {
//
//        let mirror = Mirror(reflecting: i)
//
//        for i in stats {
//            for j in mirror.children.compactMap({ ($0.label, $0.value) }) {
//                if i == j.0 {
//                    out.append(Out(name: j.0!, score: j.1 as! Int))
//                }
//            }
//        }
//    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView(pokemon: MOCK_POKEMON[0])
    }
}
