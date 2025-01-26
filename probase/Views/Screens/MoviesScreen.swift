//
//  MoviesScreen.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/26/25.
//
import SwiftUI
import SwiftData

struct MoviesScreen: View {
    @Environment(\.modelContext) private var context
    // Fetch all Movies, sorted by their title
    @Query(sort: \Film.title, order: .forward)
    private var movies: [Film]
    var body: some View {
        VStack(spacing: 16) {
            List(movies) { movie in
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    Text("Released in \(movie.releaseYear)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .listStyle(.plain)
            Button("Add Demo Movie") {
                let newMovie = Film(
                    title: "New Movie \(Date().formatted())",
                    releaseYear: 2023
                )
                context.insert(newMovie)
                try? context.save()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Movies")
    }
}
