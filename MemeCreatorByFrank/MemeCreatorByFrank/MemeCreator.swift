//
//  ContentView.swift
//  MemeCreatorByFrank
//
//  Created by Frank Chu on 4/7/22.
//

import SwiftUI

struct MemeCreator: View {
    
    @State private var memeText = ""
    @State private var textSize = 60.0
    @State private var textColor = Color.white
    
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Image("pandaplaceholder")
                .overlay(alignment: .bottom) {
                    TextField(
                        "Meme Text",
                        text: $memeText,
                        prompt: Text("")
                    )
                    .focused($isFocused)
                    .font(.system(size: textSize, weight: .heavy))
                    .shadow(radius: 10)
                    .foregroundColor(textColor)
                    .padding()
                    .multilineTextAlignment(.center)
                }
            
            
            Spacer()
            if !memeText.isEmpty {
                VStack {
                    HStack {
                        Text("Font Size")
                            .fontWeight(.semibold)
                        Slider(value: $textSize, in: 20...140)
                    }
                    
                    HStack {
                        Text("Font Color")
                            .fontWeight(.semibold)
                        ColorPicker("Font Color", selection: $textColor)
                            .labelsHidden()
                        Spacer()
                    }
                }
                .padding(.vertical)
                .frame(maxWidth: 325)
            }
            
            HStack {
                
                Button {
                    
                } label: {
                    VStack {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.largeTitle)
                            .padding(.bottom, 4)
                        
                        Text("Shuffle Photo")
                    }
                    .frame(maxWidth: 180, maxHeight: .infinity)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                
                Button {
                    isFocused = true
                } label: {
                    VStack {
                        Image(systemName: "textformat")
                            .font(.largeTitle)
                            .padding(.bottom, 4)
                        
                        Text("Add Text")
                    }
                    .frame(maxWidth: 180, maxHeight: .infinity)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxHeight: 180, alignment: .center)
            
        }
        .padding()
        .task {
            
        }
        .navigationTitle("Meme Creator")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemeCreator()
            
//            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (5th generation)"))
//            .previewDisplayName("hi")
    }
}
