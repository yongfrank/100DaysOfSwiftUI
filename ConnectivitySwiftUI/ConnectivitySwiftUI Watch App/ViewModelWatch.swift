//
//  ViewModelWatch.swift
//  ConnectivitySwiftUI Watch App
//
//  Created by Frank Chu on 8/26/22.
//

import Foundation
import WatchConnectivity

class ViewModelWatch: NSObject, WCSessionDelegate, ObservableObject {
    @Published var messageText = ""
    
    var session: WCSession
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.messageText = message[VMConstants.message.rawValue] as? String ?? "Unknown"
        }
    }
    
    
}
