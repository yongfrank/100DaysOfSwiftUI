import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TestView()
                .tabItem {
                    Label("testView", systemImage: "pencil")
                }
            
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                Image(systemName: "arrow.up")
                Image(systemName: "arrow.down")
                Image(systemName: "arrow.up.and.down")
                Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
            }
            .tabItem {
                Label("hi", systemImage: "star")
            }
            
            
        }
    }
}
