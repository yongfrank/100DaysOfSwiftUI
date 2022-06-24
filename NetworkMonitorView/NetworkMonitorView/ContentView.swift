//
//  ContentView.swift
//  NetworkMonitorView
//
//  Created by Frank Chu on 6/12/22.
//
//
//  https://www.youtube.com/watch?v=HVUsBLG7Z58
//  Check for Internet, and get other Network Information in SwiftUI with Network Monitor (iOS 2022)


import SwiftUI
import Network

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    
//    @Published var status
    @Published var isActive = false
    @Published var isExpensive = false
    @Published var isConstrained = false
    @Published var connectionType = NWInterface.InterfaceType.other
    
    init() {
        
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isActive = path.status == .satisfied
                self.isExpensive = path.isExpensive
                self.isConstrained = path.isConstrained
                
                let connectionTypes: [NWInterface.InterfaceType] = [.cellular, .wifi, .wiredEthernet]
                self.connectionType = connectionTypes.first(where: path.usesInterfaceType) ?? .other
            }
        }
        
        monitor.start(queue: queue)
    }
}


struct ContentView: View {
    @StateObject private var networkMonitor = NetworkMonitor()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Text(verbatim: "\(networkMonitor.isActive)")
            Text(verbatim: "\(networkMonitor.connectionType)")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
