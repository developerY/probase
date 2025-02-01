//
//  Blood.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI
import Charts

/// Represents a single glucose reading with optional notes and tags
struct GlucoseReading: Identifiable {
    let id = UUID()
    let date: Date
    var level: Double
    var notes: String
    var tags: [String]
}

/// Manages the glucose readings for the entire app
class GlucoseDataStore: ObservableObject {
    @Published var readings: [GlucoseReading] = []

    /// Adds a new reading to the list
    func addReading(level: Double, notes: String, tags: [String] = []) {
        let newReading = GlucoseReading(date: Date(), level: level, notes: notes, tags: tags)
        readings.append(newReading)
    }

    /// Updates an existing reading
    func updateReading(_ reading: GlucoseReading, newLevel: Double, newNotes: String, newTags: [String]) {
        guard let index = readings.firstIndex(where: { $0.id == reading.id }) else { return }
        readings[index].level = newLevel
        readings[index].notes = newNotes
        readings[index].tags = newTags
    }

    /// Removes a reading from the list
    func deleteReading(_ reading: GlucoseReading) {
        readings.removeAll { $0.id == reading.id }
    }
}

