//
//  ExmapleContent.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/26/25.
//
import SwiftUI
import SwiftData


struct ExampleContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Button -> ArticleScreen
                NavigationLink("Go to Articles") {
                    ArticlesScreen()
                }
                .buttonStyle(.borderedProminent)
                // Button -> BookScreen
                NavigationLink("Go to Books") {
                    BooksScreen()
                }
                .buttonStyle(.borderedProminent)
                // Button -> MovieScreen
                NavigationLink("Go to Movies") {
                    MoviesScreen()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Main Menu")
            .padding()
        }
    }
}
