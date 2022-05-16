import SwiftUI

struct ContentView: View {
    
    @State var isShowingVar = false
    
    var body: some View {
        VStack {
            Button {
                isShowingVar.toggle()
            } label: {
                Image(systemName: "trash")
            }
        }
        .alert("change .automatic to .visible", isPresented: $isShowingVar, titleVisibility: .automatic) {
            Button("Delete Photo", role: .destructive) {}
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This photo will be deleted from iCloud Photos on all your devices.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
