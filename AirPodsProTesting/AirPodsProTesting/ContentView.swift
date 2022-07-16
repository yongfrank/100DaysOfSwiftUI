//
//  ContentView.swift
//  AirPodsProTesting
//
//  Created by Frank Chu on 6/27/22.
//

import AVFoundation
import CoreMotion
import MapKit
import SwiftUI

class MotionManager: ObservableObject {
    var motionManger = CMHeadphoneMotionManager()
    @Published var pitch = 0.0
    @Published var roll = 0.0
    @Published var yaw = 0.0

    init() {}

    func startRecording() {
        motionManger.startDeviceMotionUpdates(to: .main) { [weak self] motion, _ in
            guard let self = self, let motion = motion else { return }
            self.pitch = motion.attitude.pitch
            self.roll = motion.attitude.roll
            self.yaw = motion.attitude.yaw
        }
    }
    func stopRecording() {
        motionManger.stopDeviceMotionUpdates()
    }

    deinit {
        motionManger.stopDeviceMotionUpdates()
    }
}

struct SoundManager {
    let leftUtterance = AVSpeechUtterance(string: "正在向左偏")
    let rightUtterance = AVSpeechUtterance(string: "正在向右偏")
    func playSound(utterance: AVSpeechUtterance) {
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-cn")
        AVSpeechSynthesizer().speak(utterance)
    }
    
    func playDegree(direction: String, degree: Double) {
        
        let utterance = AVSpeechUtterance(string: "\(direction)....\(degree)度")
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-cn")
        AVSpeechSynthesizer().speak(utterance)
    }
}

struct ContentView: View {
    @StateObject var motionHandler = MotionManager()
    let soundHandler = SoundManager()
    @State private var timerCount = 5
    var clock = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State private var isStarted = false

    var body: some View {
        ZStack {
            MapView()
            VStack {
                Text("AirPods Connection: \(String(motionHandler.motionManger.isDeviceMotionActive))")
                Text(isStarted ? "Yaw: \(motionHandler.yaw, specifier: "%.4f")" : "Yaw: Press start")
                Text(isStarted ? "Roll: \(motionHandler.roll, specifier: "%.4f")" : "Roll: Press start")
                Text(isStarted ? "Pitch: \(motionHandler.pitch, specifier: "%.4f")" : "Pitch: Press start")
                Button("Let's Start") {
                    isStarted.toggle()
                    motionHandler.stopRecording()
                    motionHandler.startRecording()
                }
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(Capsule())
            }
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .offset(x: 0, y: -200)

            if isStarted {
                if motionHandler.yaw > 0.2 {
                    Text("正在往左偏 \(motionHandler.yaw * 180 / .pi, specifier: "%.0f")º \(timerCount)s")
                        .font(.largeTitle)
                }
                if motionHandler.yaw < -0.2 {
                    Text("正在往右偏 \(motionHandler.yaw * -180 / .pi, specifier: "%.0f")º \(timerCount)s")
                        .font(.largeTitle)
                }
            }
            VStack {
                Spacer()
                HStack {
                    Button("左示例") {
                        soundHandler.playDegree(direction: "正在向左偏", degree: 32)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .clipShape(Capsule())
                    Spacer()
                    
                    Button("右示例") {
                        soundHandler.playDegree(direction: "正在向右偏", degree: 30)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .clipShape(Capsule())
                }
                
            }
            .padding()
        }
        .onAppear {
            motionHandler.startRecording()
        }
        .onReceive(clock) { _ in
            if isStarted {
                if motionHandler.yaw < -0.2 {
                    if timerCount % 5 == 0 {
                        soundHandler.playSound(utterance: soundHandler.rightUtterance)
                    }
                    if timerCount == 0 {
                        timerCount = 5
                    }
                    timerCount -= 1
                } else if motionHandler.yaw > 0.2 {
                    if timerCount % 5 == 0 {
                        soundHandler.playSound(utterance: soundHandler.leftUtterance)
                    }
                    if timerCount == 0 {
                        timerCount = 5
                    }
                    timerCount -= 1
                } else {
                    timerCount = 5
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
    }
}

struct MapView: View {
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
            // print(locations)
        }
    }
}

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 30.23598, longitude: 120.14509)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
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
