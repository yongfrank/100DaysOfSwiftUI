//
//  ContentView.swift
//  HeartRate
//
//  Created by Frank Chu on 9/21/22.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @State private var sendedMessage = ""
    @State private var reachable = "No"
    var model = ViewModelPhone()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Button {
                self.reachable = self.model.session.isReachable ? "Yes" : "No"
            } label: {
                Text(reachable)
            }
            
            TextField("Enter something you want to send.", text: $sendedMessage)
                .textFieldStyle(.roundedBorder)
            
            Button {
                self.model.session.sendMessage(
                    [WCSharedModel.message.rawValue : self.sendedMessage],
                    replyHandler: nil
                ) { error in
                    print("ERROR: \(error.localizedDescription)")
                }
            } label: {
                Text("Send")
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class ViewModelPhone: NSObject, WCSessionDelegate {
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }

    func sessionDidDeactivate(_ session: WCSession) {
        
    }


}
