//
//  NoteDetailView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/25/25.
//
import SwiftUI
import SwiftData

struct NoteDetailView: View {
    @Bindable var note: Note

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $note.title)
            }

            Section(header: Text("Body")) {
                TextEditor(text: $note.body)
                    .frame(height: 200)
            }
        }
        .navigationTitle(note.title.isEmpty ? "New Note" : note.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // Create an in-memory ModelContainer for preview purposes
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Note.self, configurations: configuration)

    // Insert sample data into the container's context
    let context = container.mainContext
    let sampleNote = Note(title: "Sample Note", body: "This is a detailed body of the sample note.")
    context.insert(sampleNote)

    // Return the view with the modelContainer environment set
    return NoteDetailView(note: sampleNote)
        .modelContainer(container)
}
