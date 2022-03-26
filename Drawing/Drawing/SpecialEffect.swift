//
//  SpecialEffect.swift
//  Drawing
//
//  Created by Frank Chu on 3/24/22.
//

import SwiftUI

struct SpecialEffect: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(.red)
                    .offset(x: -50, y: -80)
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
                
                Circle()
                    .fill(.green)
                    .offset(x: 50, y: -80)
                    .frame(width: 200 * amount)
                    .blendMode(.screen)

                
                Circle()
                    .fill(.blue)
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 200, height: 200 )
            
            Image("XcodeZeldaBotW")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)
//                .clipped()
            
            Slider(value: $amount)
                .padding()
            
            Text("\(amount)")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

struct SpecialEffect_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffect()
    }
}
