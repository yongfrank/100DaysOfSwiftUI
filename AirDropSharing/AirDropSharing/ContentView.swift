//
//  ContentView.swift
//  AirDropSharing
//
//  Created by Frank Chu on 8/26/22.
//

import SwiftUI

enum UserConstants: String {
    case uid = "uid", name = "name"
}

class User: ObservableObject {
    @AppStorage(UserConstants.uid.rawValue) var uid: String = "Unset"
    @AppStorage(UserConstants.name.rawValue) var name: String = "Unknown"
    
    init() {
        guard let id = UIDevice.current.identifierForVendor else {
            print("DEBUG: UIDevice.current failed")
            return
        }
        self.uid = id.uuidString
        print(uid)
        
        self.name = name
    }
}

class FitnessData: Codable {
    let name, user: String
    init(name: String, user: String) {
        self.name = name
        self.user = user
    }
}

struct ContentView: View {
    @StateObject var settings = User()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            TextField("name", text: $settings.name)
            Text(settings.uid)
            Button("share") {
                share(user: settings)
            }
//            ShareLink(item: URL(string: "https://github.com")!) {
//                Label("hi", systemImage: "swift")
//            }
        }
    }
    
    func share(user: User) {
//        let urlShare = URL(string: "https://github.com")
        let data = try? JSONEncoder().encode(FitnessData(name: user.name, user: user.uid))
        
        let activityVC = UIActivityViewController(activityItems: [data!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true) {
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


