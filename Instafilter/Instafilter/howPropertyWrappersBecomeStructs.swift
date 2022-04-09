//
//  howPropertyWrappersBecomeStructs.swift
//  Instafilter
//
//  Created by Frank Chu on 4/8/22.
//

import SwiftUI

struct howPropertyWrappersBecomeStructs: View {
    @State private var blurAmount = 0.0
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
            Slider(value: $blurAmount, in: 0...20)
            Button() {
                blurAmount = Double.random(in: 0...20)
                
            } label: {
                VStack(alignment: .center) {
                    
                    Image(systemName: "person.fill.checkmark")
                        .font(.largeTitle)
                        .padding(.bottom, 5)
                    Text("Random Blur")
                }
                .padding()
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .onChange(of: blurAmount) { newValue in
            print("New value is \(newValue)")
        }
    }
}

struct howPropertyWrappersBecomeStructs_Previews: PreviewProvider {
    static var previews: some View {
        howPropertyWrappersBecomeStructs()
    }
}
