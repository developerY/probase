//
//  ArticleDetailView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/26/25.
//
import SwiftUI
import SwiftData

struct ArticleDetailView: View {
    @Environment(\.modelContext) private var context
    @Bindable var article: Article


    var body: some View {
        Form {
            TextField("Title", text: $article.title)
            TextField("Body", text: $article.body, axis: .vertical)
                .lineLimit(3) // optional multi-line
        }
        .navigationTitle("Edit Article")
        .onDisappear {
            // Attempt to save changes when leaving
            try? context.save()
        }
    }
}
