//
//  ContentView.swift
//  HeartRateWatch Watch App
//
//  Created by Frank Chu on 9/21/22.
//

import SwiftUI
import WatchConnectivity
import Foundation

struct ContentView: View {
    @StateObject var model = ViewModelWatch()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text("Received: \(self.model.message)")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class ViewModelWatch: NSObject, WCSessionDelegate, ObservableObject {
    @Published var message = ""
    
    var session: WCSession
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async {
            self.message = message[WCSharedModel.message.rawValue] as? String ?? "Unknown"
        }
    }
}
