//
//  ContentView.swift
//  Motion
//
//  Created by Frank Chu on 4/26/22.
//

import SwiftUI
import CoreMotion

class MotionManager {
    private var motionManager = CMHeadphoneMotionManager()
    var pitch = 0.0
    var roll = 0.0
    var yaw = 0.0
    
    init() {
        motionManager.startDeviceMotionUpdates(to: OperationQueue()) { [weak self] motion, error in
            guard let self = self, let motion = motion else { return }
            self.pitch = motion.attitude.pitch
            self.roll = motion.attitude.roll
            self.yaw = motion.attitude.yaw
        }
    }
    deinit {
        motionManager.stopDeviceMotionUpdates()
    }
}

struct Particle: Hashable {
    let x: Double
    let y: Double
    let creationDate = Date.now.timeIntervalSinceReferenceDate
    let hue: Double
}

class ParticleSystem {
    let image = Image("spark")
    var particles = Set<Particle>()
    var center = UnitPoint.center
    
    var hue = 0.0
    
    
    func update(date: TimeInterval) {
        let deathDate = date - 1
        for particle in particles {
            if particle.creationDate < deathDate {
                particles.remove(particle)
            }
        }
        
        let newParticle = Particle(x: center.x, y: center.y, hue: hue)
        particles.insert(newParticle)
        hue += 0.01
        if hue > 1 { hue -= 1}
    }
}

struct ContentView: View {
    @State private var particleSystem = ParticleSystem()
    
    @State var motionHandler = MotionManager()
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                // drawing code here
                
                let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                particleSystem.update(date: timelineDate)
                context.blendMode = .plusLighter
//                context.addFilter(.colorMultiply(.green))
                
                particleSystem.center = UnitPoint(x: 0.5 - motionHandler.yaw, y: 0.5 - motionHandler.pitch)
                
                
                for particle in particleSystem.particles {
                    let xPos = particle.x * size.width
                    let yPos = particle.y * size.height
                    
                    var contextCopy = context
                    contextCopy.addFilter(.colorMultiply(Color(hue: particle.hue, saturation: 1, brightness: 1)))
                    contextCopy.opacity = 1 - (timelineDate - particle.creationDate)
                    contextCopy.draw(particleSystem.image, at: CGPoint(x: xPos, y: yPos))

                    
//                    context.opacity = 1 - (timelineDate - particle.creationDate)
//                    context.draw(particleSystem.image, at: CGPoint(x: xPos, y: yPos))
                }
            }
        }
        .gesture (
            DragGesture(minimumDistance: 0)
                .onChanged { drag in
                    particleSystem.center.x = drag.location.x / UIScreen.main.bounds.width
                    particleSystem.center.y = drag.location.y / UIScreen.main.bounds.height
                }
        )
        .ignoresSafeArea()
        .background(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
