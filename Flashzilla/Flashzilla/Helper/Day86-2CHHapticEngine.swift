//
//  Day86-2CHHapticEngine.swift
//  Flashzilla
//
//  Created by Frank Chu on 5/18/22.
//

import SwiftUI
import CoreHaptics

private struct Day86_2CHHapticEngine: View {
    
    @State private var engineByF: CHHapticEngine?
    
    
    var body: some View {
        Text("Hello, world")
            .onAppear(perform: prepareHaptics)
            .onTapGesture {
                complexSuccess()
            }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engineByF = try CHHapticEngine()
            try engineByF?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
            
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var eventsByF = [CHHapticEvent]()
        
        for i in stride(from: 0, through: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            eventsByF.append(event)
        }
        for i in stride(from: 0, through: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            eventsByF.append(event)
        }
        
        
        do {
            let pattern = try CHHapticPattern(events: eventsByF, parameters: [])
            let player = try engineByF?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }

}

struct Day86_2CHHapticEngine_Previews: PreviewProvider {
    static var previews: some View {
        Day86_2CHHapticEngine()
    }
}
