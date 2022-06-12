////
////  Day69-1-integrating-mapkit-with-swiftui.swift
////  BucketList
////
////  Created by Frank Chu on 6/9/22.
////
//
//import SwiftUI
//import MapKit
//
//fileprivate struct LocationTest: Identifiable {
//    let id = UUID()
//    let name: String
//    let coordinate: CLLocationCoordinate2D
//}
//
//private class Locations: ObservableObject {
//    @Published fileprivate var locationsInTheClass: [LocationTest]
//    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
//    
//    init() {
//        locationsInTheClass = [
//            LocationTest(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
//            LocationTest(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
//        ]
//    }
//}
//
//struct Day69_1_integrating_mapkit_with_swiftui: View {
//    @EnvironmentObject fileprivate var locations: Locations
//    
//    var body: some View {
////        Map(coordinateRegion: $mapRegion)
////            .ignoresSafeArea()
//        
//        NavigationView {
//            Map(coordinateRegion: $locations.mapRegion, annotationItems: locations.locationsInTheClass) { location in
//                //            MapMarker(coordinate: location.coordinate)
//                MapAnnotation(coordinate: location.coordinate) {
//                    NavigationLink {
//                        Text(location.name)
//                    } label: {
//                        Circle()
//                            .stroke(.red, lineWidth: 3)
//                            .frame(width: 44, height: 44)
////                            .onTapGesture {
////                                print("Tapped on \(location.name)")
////                            }
//                    }
//                }
//            }
//            .navigationTitle("London Explorer")
//            .ignoresSafeArea()
//        }
//    }
//}
//
//struct Day69_1_integrating_mapkit_with_swiftui_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        Day69_1_integrating_mapkit_with_swiftui()
//            .environmentObject(Locations())
//    }
//}
