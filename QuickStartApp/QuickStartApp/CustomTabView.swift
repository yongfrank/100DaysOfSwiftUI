import SwiftUI

struct CustomTabView: View {
    
    @State var index = 0
    let toolbarNames = ["Loved", "Home", "Settings", "Account"]
    let tabBarImageNames = ["suit.heart.fill", "house.fill", "gear", "person"]
    
    var body: some View {
        
        NavigationView {
            TabView(selection: $index) {
                Color.red
                    .tag(0)
                    .tabItem {
                        Image(systemName: "suit.heart.fill")
                    }
                Color.blue
                    .tag(1)
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                Color.black
                    .tag(2)
                    .tabItem {
                        Image(systemName: "gear")
                    }
                Color.yellow
                    .tag(3)
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
            }
            .ignoresSafeArea()
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Menu {
                    ForEach(0..<4) { index in
                        ButtonView(index: $index, page: index, text: toolbarNames[index], imageName: tabBarImageNames[index])
                    }
                    
                } label: {
                    Image(systemName: "list.dash")
                }
            }
            
        }
    }
}

struct ButtonView: View {
    @Binding var index: Int
    var page: Int
    var text: String
    var imageName: String
    var body: some View {
        Button {
            withAnimation {
                index = page
            }
        } label: {
            HStack {
                Text(text)
                Image(systemName: imageName)
            }
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
