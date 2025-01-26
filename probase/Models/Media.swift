//
//  Media.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/26/25.
//
import SwiftUI
import SwiftData

@Model
class Article {
    var title: String
    var body: String
    init(title: String, body: String) {
        self.title = title
        self.body  = body
    }
}
@Model
class Book {
    var name: String
    var author: String
    init(name: String, author: String) {
        self.name   = name
        self.author = author
    }
}
@Model
class Film {
    var title: String
    var releaseYear: Int
    init(title: String, releaseYear: Int) {
        self.title       = title
        self.releaseYear = releaseYear
    }
}
