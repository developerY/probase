//
//  ReportsAndSharingView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI

struct ReportsAndSharingView: View {
    @State private var dateRangeSelection = 0
    @State private var reportFormat = 0

    var body: some View {
        Form {
            Section(header: Text("Date Range")) {
                Picker("Range", selection: $dateRangeSelection) {
                    Text("Last 7 Days").tag(0)
                    Text("Last 14 Days").tag(1)
                    Text("Last 30 Days").tag(2)
                }
                .pickerStyle(.segmented)
            }

            Section(header: Text("Report Format")) {
                Picker("Format", selection: $reportFormat) {
                    Text("PDF").tag(0)
                    Text("CSV").tag(1)
                }
                .pickerStyle(.segmented)
            }

            Button("Generate Report") {
                // Generate PDF/CSV, show share sheet, etc.
            }

            // Possibly a preview or share option
            Button("Share / Export") {
                // UIActivityViewController or SwiftUI ShareLink in iOS 16+
            }
        }
        .navigationTitle("Reports & Sharing")
    }
}
