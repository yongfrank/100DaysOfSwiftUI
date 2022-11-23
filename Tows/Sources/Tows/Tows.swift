import SwiftUI
import cows // @AlwaysRightInstitute

struct ContentView: View {
    @State var searchString  = ""
    @State var matches    = allCows
    @State var selectedCow: String?
    
    let font = Font(NSFont
        .monospacedSystemFont(ofSize: NSFont.systemFontSize, weight: .regular))

    var body: some View {
        NavigationView {
            ScrollView {
                TextField("Search", text: $searchString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(8)
                    .onChange(of: searchString, perform: { nv in
                        matches = nv.isEmpty
                            ? cows.allCows
                            : cows.allCows.filter { $0.contains(searchString)}
                    })
                    Spacer()
            }
            ScrollView {
                VStack(spacing: 0) {
                    if matches.isEmpty {
                        Text("Did't find cows matching '\(searchString)' 🐮")
                    }

                    ForEach(matches.isEmpty ? allCows : matches, id: \.self) { cow in
                        Text(verbatim: cow)
                            .font(font)
                            .onDrag { NSItemProvider(object: cow as NSString ) }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                .strokeBorder()
                                .foregroundColor(.accentColor)
                                .padding(4)
                                .opacity(selectedCow == cow ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedCow = selectedCow == cow ? nil : cow
                            }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
} 
@main
struct HelloWorld: App {
    init() {
        DispatchQueue.main.async {
            NSApp.setActivationPolicy(.regular)
            NSApp.activate(ignoringOtherApps: true)
            NSApp.windows.first?.makeKeyAndOrderFront(nil)
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 640, minHeight: 320)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}