//
//  Note.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/25/25.
//
import SwiftData
import Foundation

@Model
class Note {
    // A unique ID for this note
    var id: UUID
    
    // The main title or subject
    var title: String
    
    // Body or detailed text
    var body: String
    
    // When this note was originally created
    var dateCreated: Date
    
    // An initializer that sets default values
    init(title: String, body: String, dateCreated: Date = Date()) {
        self.id = UUID()
        self.title = title
        self.body = body
        self.dateCreated = dateCreated
    }
}

