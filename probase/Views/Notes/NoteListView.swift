//
//  NotesListView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/25/25.
//
import SwiftUI
import SwiftData

struct NotesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [Note]

    var body: some View {
        NavigationStack {
            List {
                ForEach(notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                            Text(note.body)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                        }
                    }
                }
                .onDelete(perform: deleteNotes)
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addNote) {
                        Label("Add Note", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func addNote() {
        withAnimation {
            let newNote = Note(title: "New Note", body: "This is a new note.")
            modelContext.insert(newNote)
        }
    }

    private func deleteNotes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
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
