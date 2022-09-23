//
//  ContentView.swift
//  ConnectivitySwiftUI
//
//  Created by Frank Chu on 8/26/22.
//  https://betterprogramming.pub/get-started-with-watch-connectivity-with-swiftui-51722324b6f6
//  Get Started With Watch Connectivity With SwiftUI


import SwiftUI

struct ContentView: View {
    var model = ViewModelPhone()
    @State private var messageText = ""
    
    @State private var reachable = "NO"
    var body: some View {
        NavigationStack {
            ScrollView {
                
                VStack {
                    Text("Reachable \(reachable)")
                    
                    Button("Update") {
                        if self.model.session.isReachable {
                            self.reachable = "Yes"
                        } else {
                            self.reachable = "false"
                        }
                    }
                    HStack {
                        TextField("Enter to send to Watch", text: $messageText)
                            .background {
                                Color.white
                            }
                            
                        Button {
                            self.model.session.sendMessage(
                                [VMConstants.message.rawValue: self.messageText],
                                replyHandler: nil
                            ) { (error) in
                                print("DEBUG: \(error.localizedDescription)")
                            }
                            
                        } label: {
                            Text("Send")
                        }
                        
                    }
                    
                    .padding()
                    
                    .background {
                        Color.white
                    }
                    .cornerRadius(5)
                }
                .padding()
            }
            .navigationTitle("Watch Connectivity")
            .background {
                Color(.init(white: 0, alpha: 0.05))
                    .ignoresSafeArea()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
