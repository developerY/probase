//
//  GlucoseMonitorView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI

struct GlucoseMonitorView: View {
    @EnvironmentObject var dataStore: DiabetesDataStore

    @State private var glucoseLevel: Double = 100.0
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var notes: String = ""
    @State private var tags: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Glucose Monitor")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                // Current glucose reading
                HStack {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.blue)
                    Text("\(Int(glucoseLevel)) mg/dL")
                        .font(.system(size: 36, weight: .bold))
                }

                // Slider to simulate changes
                Slider(value: $glucoseLevel, in: 40...300, step: 1)
                    .padding(.horizontal)
                    .onChange(of: glucoseLevel) { newValue in
                        checkGlucoseLevel(newValue)
                    }

                // Notes and tags (basic text fields for demonstration)
                Group {
                    TextField("Notes (optional)", text: $notes)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    TextField("Tags (comma-separated)", text: $tags)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                }

                // Button to add reading
                Button(action: addReading) {
                    Label("Add Reading", systemImage: "plus.circle.fill")
                }
                .padding()
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .navigationTitle("Monitor")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Glucose Alert"),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("OK")))
            }
        }
    }

    private func addReading() {
        dataStore.addReading(
            level: glucoseLevel,
            notes: notes.trimmingCharacters(in: .whitespacesAndNewlines),
            tags: tags
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        )
        notes = ""
        tags = ""
    }

    private func checkGlucoseLevel(_ level: Double) {
        if level < 70 {
            alertMessage = "Low Glucose Detected! (\(Int(level)) mg/dL)"
            showAlert = true
        } else if level > 180 {
            alertMessage = "High Glucose Detected! (\(Int(level)) mg/dL)"
            showAlert = true
        }
    }
}

// MARK: - SwiftUI Preview
struct GlucoseMonitorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GlucoseMonitorView()
                .previewDisplayName("Default Preview")
                .previewDevice("iPhone 15 Pro")
            
            GlucoseMonitorView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode Preview")
        }
    }
}
