//
//  GlobalNavigationView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/25/25.
//
import SwiftUI
import SwiftData

struct GlobalNavigationView: View {
    @State private var path: [AppDestination] = []

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Button("Notes") {
                    navigate(to: .items)
                }
                Button("Items") {
                    navigate(to: .items)
                }
                Button("Settings") {
                    navigate(to: .settings)
                }
            }
            .navigationTitle("Global Navigation")
            .navigationDestination(for: AppDestination.self) { destination in
                switch destination {
                case .notes:
                    NotesListView()
                        .modelContainer(for: [Note.self]) // Attach ModelContext here
                case .items:
                    ContentView()
                case .settings:
                    Text("Settings Screen")
                }
            }
        }
    }

    private func navigate(to destination: AppDestination) {
        if !path.contains(destination) {
            path.append(destination)
        }
    }
}

enum AppDestination: Hashable {
    case notes
    case items
    case settings
}
