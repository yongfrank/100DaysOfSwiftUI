import SwiftUI

struct ContentView: View {
    let imageNames = ["kier-in-sight", "patrick-mueller"]

    var body: some View {
        List(imageNames, id: \.self) { image in
            Image(image).resizable().frame(width: 40, height: 40)
            Text(image)
        }
    }
}
