//
//  QuickLogView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI

struct QuickLogView: View {
    @State private var glucoseValue: String = ""
    @State private var date = Date()
    @State private var notes: String = ""
    @State private var showInsulinOptions = false
    @State private var insulinDose: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [.pink.opacity(0.5), .orange.opacity(0.5)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    // Styled form with a custom background
                    Form {
                        Section(header: Text("Glucose Reading")) {
                            TextField("BG (e.g. 5.8)", text: $glucoseValue)
                                .keyboardType(.decimalPad)
                            
                            DatePicker("Timestamp", selection: $date, displayedComponents: .hourAndMinute)
                            TextField("Notes or tags", text: $notes)
                        }

                        if showInsulinOptions {
                            Section(header: Text("Insulin")) {
                                TextField("Bolus dose (units)", text: $insulinDose)
                                    .keyboardType(.decimalPad)
                            }
                        }

                        Button(showInsulinOptions ? "Hide Insulin Options" : "Show Insulin Options") {
                            withAnimation {
                                showInsulinOptions.toggle()
                            }
                        }

                    
                        Button("Save Entry") {
                            // Save logic here
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.orange)
                        .padding()
                    }
                    .scrollContentBackground(.hidden)  // Remove form background to show gradient
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(16)
                    .padding()
                }
                .navigationTitle("Quick Log")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }

    // MARK: - Section Header with Icon
    private func sectionHeader(title: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding(8)
        .background(Color.purple.opacity(0.8))
        .cornerRadius(8)
    }
}

// MARK: - Preview
struct QuickLogView_Previews: PreviewProvider {
    static var previews: some View {
        QuickLogView()
            .preferredColorScheme(.light)
    }
}

