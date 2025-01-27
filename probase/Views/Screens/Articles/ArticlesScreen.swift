//
//  ArticlesScreen.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/26/25.
//
import SwiftUI
import SwiftData

struct ArticlesScreen: View {
    @Environment(\.modelContext) private var context
    // Query all Article objects, sorted by their 'title' ascending
    @Query(sort: \Article.title, order: .forward)
    private var articles: [Article]

    var body: some View {
        VStack(spacing: 16) {
            List(articles) { article in
                // Wrap each row in a NavigationLink
                NavigationLink(destination: ArticleDetailView(article: article)) {
                    VStack(alignment: .leading) {
                        Text(article.title)
                            .font(.headline)
                        Text(article.body)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .listStyle(.plain)

            Button("Add Demo Article") {
                let newArticle = Article(
                    title: "New Article \(Date().formatted())",
                    body: "This is a sample article body."
                )
                context.insert(newArticle)
                try? context.save()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Articles")
    }
}
