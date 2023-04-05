//
//  ContentView.swift
//  Bookworm
//
//  Created by Frank Chu on 4/5/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var booksByF: FetchedResults<Book>
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(booksByF) { bookTemp in
                    NavigationLink {
                        Text(bookTemp.title ?? "Unknown Title")
                    } label: {
                        HStack {
                            EmojiRatingView(rating: bookTemp.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(bookTemp.title ?? "Unknown Title")
                                    .font(.headline)
                                    
                                Text(bookTemp.author ?? "Unknown Arthor")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
