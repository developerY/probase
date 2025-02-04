//
//  ReportsSharingView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/3/25.
//
import SwiftUI

enum ReportFormat: String, CaseIterable, Identifiable {
    case pdf = "PDF Summary"
    case csv = "CSV Export"
    
    var id: String { self.rawValue }
}

struct ReportsSharingView: View {
    // MARK: - State Properties
    @State private var startDate: Date = Calendar.current.date(byAdding: .day, value: -14, to: Date()) ?? Date()
    @State private var endDate: Date = Date()
    @State private var selectedFormat: ReportFormat = .pdf
    
    var body: some View {
        NavigationView {
            ZStack {
                // Edge-to-edge gradient background: Pink to Yellow
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.3), Color.yellow.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header Title
                        Text("Reports & Sharing")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        // Date Range Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Select Date Range")
                                .font(.headline)
                            
                            // Start Date Picker
                            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                                .labelsHidden()
                            
                            // End Date Picker
                            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                                .labelsHidden()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                        
                        // Report Format Selector
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Report Format")
                                .font(.headline)
                            Picker("Report Format", selection: $selectedFormat) {
                                ForEach(ReportFormat.allCases) { format in
                                    Text(format.rawValue).tag(format)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                        
                        // Generate Report Button
                        Button(action: {
                            // Implement the report generation functionality here.
                        }) {
                            HStack {
                                Image(systemName: "doc.fill")
                                Text("Generate Report")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        
                        // Share Options Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Share Options")
                                .font(.headline)
                            HStack(spacing: 16) {
                                ShareOptionButton(title: "Email", systemImage: "envelope.fill")
                                ShareOptionButton(title: "Messages", systemImage: "message.fill")
                                ShareOptionButton(title: "Save File", systemImage: "square.and.arrow.down.fill")
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Reports & Sharing")
        }
    }
}

// A reusable view for individual share option buttons.
struct ShareOptionButton: View {
    var title: String
    var systemImage: String
    
    var body: some View {
        Button(action: {
            // Implement share functionality for this option.
        }) {
            VStack(spacing: 4) {
                Image(systemName: systemImage)
                    .font(.title2)
                    .foregroundColor(.blue)
                    .padding(8)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Circle())
                Text(title)
                    .font(.footnote)
                    .foregroundColor(.primary)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
    }
}

struct ReportsSharingView_Previews: PreviewProvider {
    static var previews: some View {
        ReportsSharingView()
    }
}

