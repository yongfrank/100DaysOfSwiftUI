//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Frank Chu on 1/18/23.
//

import SwiftUI

struct User {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        print("User \(name) was created")
    }
    
//    deinit {
//        print("User \(name) died")
//    }
}

struct ContentView: View {
    @State private var user = User(name: "Frank", age: 20)
    var body: some View {
        VStack {
            Text("hi \(user.name) \(user.age)")
            TextField("name", text: $user.name)
                .textFieldStyle(.roundedBorder)
            TextField("age", text: $user.age.intStringConvert())
                .textFieldStyle(.roundedBorder)
        }
        
    }
}

extension Binding where Value == Int {
    func intStringConvert() -> Binding<String> {
        return Binding<String> {
            return String(self.wrappedValue)
        } set: { stringValue in
            self.wrappedValue = Int(stringValue) ?? 0
        }
    }
}

//struct Comment: Codable, Hashable {
//    var content: String
//    var date: String
//}
//
//struct ContentView: View {
//    let url = URL(string: "https://studies.cs.helsinki.fi/exampleapp/data.json")!
//    @State var comments = [Comment]()
//
//    var body: some View {
//        List(self.comments, id: \.self, rowContent: { comment in
//            HStack {
//                Text(getDate(dateString: comment.date).formatted(date: .omitted, time: .standard))
//                Text(comment.content)
//            }
//        })
//            .onAppear {
//                self.parse()
//            }
//    }
//    func getDate(dateString: String) -> Date {
////        let strategy = Date.ParseStrategy(format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits)T\(hour: .twoDigits(clock: .twentyFourHour, hourCycle: .zeroBased)):\(minute: .twoDigits):\(second: .twoDigits)", timeZone: .current)
////        guard let date = try? Date(dateString, strategy: strategy) else { return Date.now }
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        guard let date = formatter.date(from: dateString) else { return Date.now }
//        return date
//    }
//
//    func parse() {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else { print("download failure"); return }
//            if let comments = try? JSONDecoder().decode([Comment].self, from: data) {
//                self.comments = comments
//                print(comments)
//            } else {
//                print("failure")
//            }
//        }
//        .resume()
//    }
//}

//struct ContentView: View {
//    @State private var presentAlert = false
//    @State private var text = ""
//    @State private var arrayOfList = ["TEST"]
//    var body: some View {
//        NavigationView {
//            VStack {
//                List(arrayOfList, id: \.self) { item in
//                    Text(item)
//                }
//            }
//            .toolbar {
//                ToolbarItem {
//                    Button {
//                        presentAlert.toggle()
//                    } label: {
//                        Label("12", systemImage: "plus")
//                    }
//                }
//            }
//            .alert("Add List", isPresented: $presentAlert) {
//                TextField("Title", text: $text)
//                Button("Cancel") {}
//                Button("OK") {
//                    arrayOfList.append(text)
//                    self.text = ""
//                }
//            } message: {
//                Text("hhhh")
//            }
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
