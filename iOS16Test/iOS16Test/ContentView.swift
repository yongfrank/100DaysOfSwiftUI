import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

extension ContentView {
    @MainActor class viewmodel: ObservableObject {
        @Published var results = [Result]()

        init() {
//            fetchMusic()
            Task {
                await fetchMusic()
            }
        }
            

        func fetchMusic() async {
            guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
                print("wrong url")
                return
            }
            
            if let (data, _) = try? await URLSession.shared.data(from: url) {
                if let decode = try? JSONDecoder().decode(Response.self, from: data) {
                    self.results = decode.results
                }
            }
            
//            URLSession.shared.dataTask(with: url) { data, _, _ in
//                guard let data = data else {
//                    print("wrong data")
//                    return
//                }
//                print(data)
//                guard let decode = try? JSONDecoder().decode(Response.self, from: data) else {
//                    print("wrong data")
//                    return
//                }
//                print(decode)
//                DispatchQueue.main.async {
//                    self.results = decode.results
//                }
//                print(self.results)
//            }
//            .resume()
        }
    }
}

struct ContentView: View {
//    @State private var results = [Result]()
    @StateObject var results = viewmodel()

    var body: some View {
        VStack {
            Text("HI")
            Text("hi")
            List(results.results, id: \.trackId) { item in
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }
//            .task {
//                await loadData()
//            }
        }
    }

//    func loadData() async {
//        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
//            print("Invalid URL")
//            return
//        }
//
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                results = decodedResponse.results
//            }
//        } catch {
//            print("Invalid data")
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
