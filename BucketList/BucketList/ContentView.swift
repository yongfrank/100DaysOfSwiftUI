//
//  ContentView.swift
//  BucketList
//
//  Created by Frank Chu on 6/8/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewmodel = ViewModel()
    
    var body: some View {
        ZStack {
            if viewmodel.isUnlocked {
                Map(coordinateRegion: $viewmodel.mapRegion, annotationItems: viewmodel.locations, annotationContent: { location in
                    //                MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                            
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewmodel.selectedPlace = location
                        }
                    }
                })
                .ignoresSafeArea()
                Circle()
                    .fill(.blue)
                    .frame(width: 32, height: 32)
                    .opacity(0.3)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            
                            viewmodel.addLocation()
                            
                            
                            //                        viewmodel.locations.append(Location(id: UUID(), name: "New location", description: "", latitude: viewmodel.mapRegion.center.latitude, longitude: viewmodel.mapRegion.center.longitude))
                        } label: {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .background(.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Capsule())
                        .padding(.trailing)
                    }
                }
            } else {
                Button("Unlock Places") {
                    print("is authenticating")
                    viewmodel.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .sheet(item: $viewmodel.selectedPlace) { place in
            EditView(location: place) { newLocation in
                viewmodel.update(location: newLocation)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
