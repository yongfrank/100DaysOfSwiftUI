//
//  ContentView.swift
//  AirPodsProTesting
//
//  Created by Frank Chu on 6/27/22.
//

import AVFoundation
import CoreMotion
import SwiftUI

class MotionManager: ObservableObject {
    var motionManger = CMHeadphoneMotionManager()
    @Published var pitch = 0.0
    @Published var roll = 0.0
    @Published var yaw = 0.0

    init() {
        
    }
    
    func startRecording() {
        motionManger.startDeviceMotionUpdates(to: .main) { [weak self] motion, _ in
            guard let self = self, let motion = motion else { return }
            self.pitch = motion.attitude.pitch
            self.roll = motion.attitude.roll
            self.yaw = motion.attitude.yaw
            
        }
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
}



struct ContentView: View {
    @StateObject var motionHandler = MotionManager()
    let soundHandler = SoundManager()
    @State private var timerCount = 5
    var clock = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                Text("AirPods Connection: \(String(motionHandler.motionManger.isDeviceMotionActive))")
                Text("Yaw: \(motionHandler.yaw, specifier: "%.4f")")
                Text("Roll: \(motionHandler.roll, specifier: "%.4f")")
                Text("Pitch: \(motionHandler.pitch, specifier: "%.4f")")
                Button("Let's Start") {
                    motionHandler.startRecording()
                }
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(Capsule())
            }
            if motionHandler.yaw > 0.2 {
                Text("正在往左偏 \(timerCount)s").offset(x: 0, y: -100)
            }
            if motionHandler.yaw < -0.2 {
                Text("正在往右偏 \(timerCount)s").offset(x: 0, y: -100)
            }
        }
        .onReceive(clock) { _ in
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
