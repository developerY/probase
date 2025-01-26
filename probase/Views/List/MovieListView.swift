//
//  MovieList.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/25/25.
//
import SwiftUI
import SwiftData


struct MovieListView: View {
    @Query(sort: \Movie.title) private var movies: [Movie]
    @Environment(\.modelContext) private var context


    var body: some View {
        List {
            ForEach(movies) { movie in
                Text(movie.title)
            }
        }
    }
}


#Preview {
    MovieListView()
        .modelContainer(SampleData.shared.modelContainer)
}