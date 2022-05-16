//
//  ManuallyPublishingObservableobject.swift
//  HotProspects
//
//  Created by Frank Chu on 5/11/22.
//

import SwiftUI

//@MainActor
class DelayedUpdater: ObservableObject {
    @Published var value = 0

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ManuallyPublishingObservableobject: View {
    
    @ObservedObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

struct ManuallyPublishingObservableobject_Previews: PreviewProvider {
    static var previews: some View {
        ManuallyPublishingObservableobject()
    }
}