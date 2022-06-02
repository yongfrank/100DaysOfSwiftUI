//
//  Day87-2How-to-be-notified-when-your-swiftui-app-moves-to-the-background.swift
//  Flashzilla
//
//  Created by Frank Chu on 5/19/22.
//

import SwiftUI

struct Day87_2How_to_be_notified_when_your_swiftui_app_moves_to_the_background: View {
    @Environment(\.scenePhase) var scenePhaseByF
    
    var body: some View {
        Text("Hello, world")
            .padding()
            .onChange(of: scenePhaseByF) { newValue in
                if newValue == .active {
                    print("Active")
                } else if newValue == .inactive {
                    print("Inactive")
                } else if newValue == .background {
                    print("Background")
                }
            }
    }
}

struct Day87_2How_to_be_notified_when_your_swiftui_app_moves_to_the_background_Previews: PreviewProvider {
    static var previews: some View {
        Day87_2How_to_be_notified_when_your_swiftui_app_moves_to_the_background()
    }
}
