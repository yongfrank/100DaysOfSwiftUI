//
//  Day87-1TriggeringEventsRepeatedly.swift
//  Flashzilla
//
//  Created by Frank Chu on 5/19/22.
//

import SwiftUI

struct Day87_1TriggeringEventsRepeatedly: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State var counter = 0
    
    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                counter += 1
                
            }
    }
}

struct Day87_1TriggeringEventsRepeatedly_Previews: PreviewProvider {
    static var previews: some View {
        Day87_1TriggeringEventsRepeatedly()
    }
}
