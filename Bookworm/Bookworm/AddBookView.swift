//
//  AddBookView.swift
//  Bookworm
//
//  Created by Frank Chu on 4/6/22.
//  https://www.hackingwithswift.com/books/ios-swiftui/creating-books-with-core-data

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismissInContentView

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genere", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        let newBookInView = Book(context: moc)
                        newBookInView.id = UUID()
                        newBookInView.title = title
                        newBookInView.genre = genre
                        newBookInView.author = author
                        newBookInView.review = review
                        newBookInView.rating = Int16(rating)
                        
                        try? moc.save()
                        dismissInContentView()
                    }
                }
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
