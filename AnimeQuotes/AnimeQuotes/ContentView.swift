//
//  ContentView.swift
//  AnimeQuotes
//
//  Created by Frank Chu on 6/12/22.
//

import SwiftUI

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        // self.url = Bundile.main.url
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Fail to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Fail to load \(file) in bundle.")
        }
        
        guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Fail to decode \(file) from bundle.")
        }
        return decoded
    }
    
//    let url = Bundle.main.url(forResource: "quotes.json", withExtension: nil)
//    let data = try! Data(contentsOf: url!)
//    let decoded = try! JSONDecoder().decode([Quote].self, from: data)
}

struct ContentView: View {
    @State var refreshed = false
    @StateObject var vm = ViewModel(testMode: true)
//    @State var quotes: [Quote] = Quote.SampleQuotes
//    {
//        refreshed ? Quote.SampleQuotes : Quote.SampleQuotes.shuffled()
//    }
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var coreDataQuotes: FetchedResults<QuoteEntity>
    
    var body: some View {
        
        NavigationStack {
            Button("Load Core Data") {
                guard let sampleQuoteCD = Quote.SampleQuotes.shuffled().first else { return }
                
                let ani = sampleQuoteCD.anime
                let quo = sampleQuoteCD.quote
                let char = sampleQuoteCD.character
                
                let cdQuo = QuoteEntity(context: moc)
                cdQuo.id = UUID()
                cdQuo.anime = ani
                cdQuo.quote = quo
                cdQuo.character = char
                try? moc.save()
            }
            List(coreDataQuotes) { quote in
                Text(quote.anime ?? "Unknown")
                Text(quote.quote ?? "Unknown")
                Text(quote.character ?? "Core Data Unknown")
            }
            List {
                Text("Hello, World! 🥳 I'm Frank~~")
                
                    
                ForEach(vm.quotes) { quote in
                    ItemView(quote: quote)
                        .padding(4)
                }
            }
            .refreshable {
                // Refresh
//                refreshed.toggle()
//                quotes = [Quote.SampleQuotes.shuffled().first!]
                vm.makeApiRequest()
            }
            .navigationTitle("Anime Quotes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
