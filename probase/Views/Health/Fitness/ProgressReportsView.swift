//
//  ProgressReportsView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/5/25.
//
import SwiftUI
import Charts

struct ProgressReportsView: View {
    // MARK: - State Properties
    @State private var selectedTimeRange: String = "Week"
    let timeRanges = ["Day", "Week", "Month", "Year"]
    
    // Dummy data for a line chart representing steps over time.
    let progressData: [ProgressData] = [
        ProgressData(date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, steps: 6000),
        ProgressData(date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, steps: 8000),
        ProgressData(date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, steps: 7500),
        ProgressData(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, steps: 9000),
        ProgressData(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, steps: 8500),
        ProgressData(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, steps: 9500),
        ProgressData(date: Date(), steps: 10000)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient: Indigo to Blue.
                LinearGradient(
                    gradient: Gradient(colors: [Color.indigo.opacity(0.2), Color.blue.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Header: Screen title and time range picker.
                        VStack(spacing: 8) {
                            Text("Progress & Reports")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Picker("Time Range", selection: $selectedTimeRange) {
                                ForEach(timeRanges, id: \.self) { range in
                                    Text(range).tag(range)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.horizontal)
                        }
                        .padding(.top)
                        
                        // Line Chart for Steps Over Time
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Steps Over Time")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            Chart {
                                ForEach(progressData) { data in
                                    LineMark(
                                        x: .value("Date", data.date),
                                        y: .value("Steps", data.steps)
                                    )
                                    .foregroundStyle(Color.green)
                                    .symbol(Circle())
                                }
                            }
                            .frame(height: 200)
                            .padding(.horizontal)
                        }
                        
                        // Summary Metrics Row using StatTileViewFitness
                        HStack(spacing: 16) {
                            // For example, show the most recent day's steps as "Total Steps"
                            StatTileViewFitness(title: "Total Steps", value: "\(progressData.last?.steps ?? 0)")
                            // You can add more metrics here if needed.
                        }
                        .padding(.horizontal)
                        
                        // Generate Report Button
                        Button(action: {
                            // Implement your report generation logic here.
                        }) {
                            HStack {
                                Image(systemName: "doc.plaintext")
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
                        
                        Spacer()
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Progress & Reports")
        }
    }
}

// MARK: - Supporting Data Model

struct ProgressData: Identifiable {
    let id = UUID()
    let date: Date
    let steps: Int
}



// MARK: - Preview Provider

struct ProgressReportsView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressReportsView()
            .environment(\.colorScheme, .light)
    }
}

