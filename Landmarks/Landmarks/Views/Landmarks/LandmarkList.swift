//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Frank Chu on 3/13/22.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    
    
    var body: some View {
        
        
        NavigationView {
            
            
            List {
                
                
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
                
                
            }
            .navigationTitle("Landmarks")
            
            
        }
        
        
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
//        LandmarkList()
//            .environmentObject(ModelData())
        ForEach(["iPhone SE (2nd generation)", "iPhone 12 Pro", "iPad Pro (12.9-inch) (5th generation)"], id: \.self) { deviceName in
                LandmarkList()
                    .environmentObject(ModelData())
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
    }
}


