//
//  ContentView.swift
//  PhotosPickerSwiftUI
//
//  Created by Frank Chu on 8/23/22.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @StateObject var imagePicker = ImagePicker()
    
    var body: some View {
        TabView {
            NavigationStack {
                VStack {
                    if let image = imagePicker.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap the menu bar button to select multiple photos.")
                    }
                        
                }
                .padding()
                .navigationTitle("Multiple Picker")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        PhotosPicker(selection: $imagePicker.imageSelection) {
                            Image(systemName: "photo")
                                .imageScale(.large)
                        }
                    }
                }
            }
            .tabItem {
                Label("Sigle", systemImage: "photo")
            }
            MultiImagePickerView()
                .tabItem {
                    Label("Multiple", systemImage: "photo.on.rectangle.angled")
                }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
