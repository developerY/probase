//
//  HeartHistoryView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/3/25.
//
import SwiftUI
import Charts

struct HeartHistoryView: View {
    // Time range options for the segmented control
    let timeRanges = ["Day", "Week", "Month", "Custom"]
    @State private var selectedTimeRange = "Day"
    
    // Dummy heart history data for the chart and event list
    let heartHistory: [HeartEvent] = [
        HeartEvent(timestamp: Date().addingTimeInterval(-3600 * 8), heartRate: 70, note: "Morning walk"),
        HeartEvent(timestamp: Date().addingTimeInterval(-3600 * 6), heartRate: 75, note: "Breakfast"),
        HeartEvent(timestamp: Date().addingTimeInterval(-3600 * 4), heartRate: 85, note: "Afternoon activity"),
        HeartEvent(timestamp: Date().addingTimeInterval(-3600 * 2), heartRate: 65, note: "Rest"),
        HeartEvent(timestamp: Date().addingTimeInterval(-3600 * 1), heartRate: 80, note: "Evening run")
    ]
    
    // Computed stats: average, maximum, and minimum heart rate
    var averageHR: Int {
        let total = heartHistory.reduce(0) { $0 + $1.heartRate }
        return total / heartHistory.count
    }
    
    var maxHR: Int {
        heartHistory.map { $0.heartRate }.max() ?? 0
    }
    
    var minHR: Int {
        heartHistory.map { $0.heartRate }.min() ?? 0
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Edge-to-edge background gradient
                LinearGradient(
                    gradient: Gradient(colors: [ .blue.opacity(0.3), .orange.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Time range segmented control
                        Picker("Time Range", selection: $selectedTimeRange) {
                            ForEach(timeRanges, id: \.self) { range in
                                Text(range).tag(range)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                        
                        // Detailed heart rate chart using Swift Charts
                        Chart {
                            ForEach(heartHistory) { event in
                                LineMark(
                                    x: .value("Time", event.timestamp),
                                    y: .value("Heart Rate", event.heartRate)
                                )
                                .interpolationMethod(.catmullRom)
                                .foregroundStyle(.red)
                                .lineStyle(StrokeStyle(lineWidth: 2))
                            }
                        }
                        .frame(height: 200)
                        .padding(.horizontal)
                        
                        // Stats row showing average, maximum, and minimum heart rate
                        HStack {
                            StatItemView(title: "Avg HR", value: "\(averageHR) BPM")
                            StatItemView(title: "Max HR", value: "\(maxHR) BPM")
                            StatItemView(title: "Min HR", value: "\(minHR) BPM")
                        }
                        .padding(.horizontal)
                        
                        Divider()
                        
                        // List of heart events
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(heartHistory) { event in
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        // Display the event time
                                        Text(event.timestamp, style: .time)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                        // Display heart rate value
                                        Text("\(event.heartRate) BPM")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        // Optionally display an event note
                                        if let note = event.note, !note.isEmpty {
                                            Text(note)
                                                .font(.footnote)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(8)
                                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Export / Share Data Button
                        Button(action: {
                            // Add export or share functionality here.
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Export / Share Data")
                            }
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Heart History")
        }
    }
}

// MARK: - Supporting Data Model

struct HeartEvent: Identifiable {
    let id = UUID()
    let timestamp: Date
    let heartRate: Int
    var note: String? = ""
}

// A reusable view for individual stat items in the stats row
struct StatItemView: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(value)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Preview

struct HeartHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HeartHistoryView()
    }
}

