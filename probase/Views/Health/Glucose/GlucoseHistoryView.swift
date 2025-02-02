//
//  GlucoseHistoryView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI

struct GlucoseHistoryView: View {
    var body: some View {
        NavigationView {
            VStack {
                // A placeholder large chart area
                GlucoseHistoryChartView()
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blue.opacity(0.2))
                    .overlay(Text("Glucose Chart").foregroundColor(.blue))
                    .padding()
                    .frame(height: 200)

                // Time Range Picker (Day/Week/Month)
                Picker("Range", selection: .constant(0)) {
                    Text("Day").tag(0)
                    Text("Week").tag(1)
                    Text("Month").tag(2)
                }
                .pickerStyle(.segmented)
                .padding()

                // Key stats row
                HStack {
                    Text("Avg BG: 6.2")
                    Spacer()
                    Text("TIR: 74%")
                    Spacer()
                    Text("SD: 1.2")
                }
                .padding(.horizontal)

                // Scrollable list of events
                List {
                    Section(header: Text("Today")) {
                        ForEach(0..<5, id: \.self) { i in
                            HStack {
                                Text("08:00 - 5.4 mmol/L")
                                Spacer()
                                Text("Fasting")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    Section(header: Text("Yesterday")) {
                        ForEach(0..<5, id: \.self) { i in
                            HStack {
                                Text("10:00 - 6.8 mmol/L")
                                Spacer()
                                Text("Post-meal")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("History")
        }
    }
}

// MARK: - Preview
struct GlucoseHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        GlucoseHistoryView()
            .environmentObject(DiabetesDataStore())
    }
}
