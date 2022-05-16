import SwiftUI

struct ContentView: View {
    
    
    @State var welcomePageShow = true
    var body: some View {
        VStack {
            Text("HI")
            Image("figmaLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .sheet(isPresented: $welcomePageShow) {
            WelcomeView(isFirstLaunch: true, appName: "HI", features: [WelcomeFeature(image: Image(systemName: "app.fill"), title: "Feature", body: "This feature is good."), WelcomeFeature(image: Image(systemName: "app.fill"), title: "Feature", body: "This feature is good."), WelcomeFeature(image: Image(systemName: "app.fill"), title: "Feature", body: "This feature is good.")])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

