//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Frank Chu on 5/27/22.
//

import SwiftUI

struct ContentView: View {
    let color: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row # \(index)")
                            .frame(maxWidth: .infinity)
                        
                        /// Q3: Change the Color
//                            .background(color[index % 7])
                            .background(Color(
                                hue: geo.frame(in: .global).minY / fullView.size.height,
                                saturation: 1,
                                brightness: 1)
                                        )
                        
                        /// Q2: 3D Rotate
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                        
                        /// Q1: Opacity
                            .opacity(geo.frame(in: .global).minY / (fullView.size.height / 2))

                            .scaleEffect(geo.frame(in: .global).minY / (fullView.size.height / 2))
                            
                            .onTapGesture {
                                print(geo.frame(in: .global).minY)
                                print("fullview \(fullView.size.height)")
                            }
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
