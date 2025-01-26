//
//  BooksScreen.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/26/25.
//
import SwiftUI
import SwiftData

struct BooksScreen: View {
    @Environment(\.modelContext) private var context
    // Fetch all Books, sorted by name
    @Query(sort: \Book.name, order: .forward)
    private var books: [Book]
    var body: some View {
        VStack(spacing: 16) {
            List(books) { book in
                VStack(alignment: .leading) {
                    Text(book.name)
                        .font(.headline)
                    Text("by \(book.author)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .listStyle(.plain)
            Button("Add Demo Book") {
                let newBook = Book(
                    name: "New Book \(Date().formatted())",
                    author: "Author Name"
                )
                context.insert(newBook)
                try? context.save()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Books")
    }
}
