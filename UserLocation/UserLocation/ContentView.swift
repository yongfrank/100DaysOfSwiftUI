//
//  ContentView.swift
//  UserLocation
//
//  Created by Frank Chu on 6/28/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject var vm = LocationViewModel()
    @State var locations = [Location]()
    var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    let annotationTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        Map(coordinateRegion: $vm.region, showsUserLocation: true, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                Image(systemName: "circlebadge.fill")
            }
        }
            .ignoresSafeArea()
            .onAppear {
                vm.checkIfLocationServicesIsEnabled()
            }
            .onReceive(timer) { nowTime in
                vm.checkIfLocationServicesIsEnabled()
                print(nowTime)
            }
            .onReceive(annotationTimer) { _ in
                locations.append(Location(latitude: vm.region.center.latitude, longitude: vm.region.center.longitude))
                //print(locations)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
    }
}

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 30.31627, longitude: 120.36207)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
}

struct Location: Identifiable {
    let id = UUID()
    var latitude: Double
    var longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Location Services does not enable.")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("It's normal")
            region = MKCoordinateRegion(center: locationManager.location?.coordinate ?? MapDetails.startingLocation, span: MapDetails.defaultSpan)
        case .denied, .restricted:
            print("It's not normal")
        @unknown default:
            break
        }
        
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
