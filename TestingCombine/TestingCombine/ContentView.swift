//
//  ContentView.swift
//  TestingCombine
//
//  Created by Frank Chu on 7/8/22.
//

import Combine
import SwiftUI

struct User: Codable, Identifiable {
    var id: Int
    var username, phone, website: String
}

class ContentViewModel: ObservableObject {
    @Published var time = ""
    @Published var user = [User]()

    let fmt: DateFormatter = {
        let fmt = DateFormatter()
        fmt.timeStyle = .medium
        fmt.dateStyle = .long
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return fmt
    }()

    var cancelable: AnyCancellable?
    var cancallableOfURL: AnyCancellable?
    init() {
        addTimeSubscribe()
        addDataSubscribe()
    }

    private var cancellableOfURL = Set<AnyCancellable>()

    private func addDataSubscribe() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }

        cancallableOfURL = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let responseStat = response as? HTTPURLResponse, responseStat.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { _ in

            } receiveValue: { receiveValue in
                self.user = receiveValue
            }
//            .store(in: &cancellableOfURL)
    }

    private func addTimeSubscribe() {
        cancelable = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            .receive(on: RunLoop.main)
            .sink { output in
                self.time = self.fmt.string(from: output)
            }
//            .store(in: &cancellableOfURL)
    }
}

struct ContentView: View {
    @StateObject var vmSO = ContentViewModel()
    @ObservedObject var vm = ContentViewModel()
    @State private var time = Date.now
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//        .sink { output in
//            print(output)
//        }
    let a = (0 ..< 3)
    var body: some View {
        NavigationView {
            VStack {
//                Text(time.formatted(date: .omitted, time: .standard))
                Text(vm.time)
                    .font(.system(size: 32)).bold()
                List {
                    ForEach(vm.user) { usr in
                        VStack(alignment: .leading) {
                            Text(usr.username)
                                .font(.system(size: 32)).bold()
                            Text(usr.phone)
                            Text(usr.website)
                        }
                    }
                }
                ForEach(a, id: \.self) { index in
                    Text("Row \(index)")
                }
            }
        }
//        .onReceive(timer) { output in
//            time = output
//            print(time)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
