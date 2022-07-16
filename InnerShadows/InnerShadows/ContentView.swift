//
//  ContentView.swift
//  InnerShadows
//
//  Created by Frank Chu on 6/27/22.
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    private let motionmanager = CMMotionManager()
    @Published var x = 0.0
    @Published var y = 0.0
    
    init() {
        motionmanager.deviceMotionUpdateInterval = 1 / 15
        motionmanager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
            guard let motion = motion?.attitude else { return }
            self?.x = motion.roll
            self?.y = motion.pitch
        }
    }
    deinit {
        motionmanager.stopDeviceMotionUpdates()
    }
}
struct ContentView: View {
    @StateObject var motion = MotionManager()
    
    var body: some View {
        VStack {
            Image(systemName: "arrow.down.message.fill")
                .foregroundStyle(
                    .blue.gradient.shadow(
                        .inner(color: .black, radius: 10, x: motion.x * 50, y: motion.y * 50)
                        )
                    .shadow(
                        .drop(color: .black.opacity(0.2), radius: 10, x: motion.x * 50, y: motion.y * 50)
                        )
                )
                .font(.system(size: 300).bold())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
