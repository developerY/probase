//
//  SleepHistoryView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/4/25.
//
import SwiftUI
import Charts

struct SleepHistoryView: View {
    // Time range options for the segmented control.
    let timeRanges = ["Day", "Week", "Month", "Custom"]
    @State private var selectedTimeRange = "Day"
    
    // Dummy sleep entries data (for chart and list).
    let sleepEntries: [SleepEntry] = [
        // Sample entries; adjust the dates and values as needed.
        SleepEntry(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, duration: 7.5, note: "Restful"),
        SleepEntry(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, duration: 6.8, note: "Interrupted"),
        SleepEntry(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, duration: 7.2, note: "Average"),
        SleepEntry(date: Date(), duration: 8.0, note: "Great Sleep")
    ]
    
    // Computed summary statistics.
    var averageSleep: Double {
        let total = sleepEntries.reduce(0) { $0 + $1.duration }
        return total / Double(sleepEntries.count)
    }
    var bestSleep: Double {
        sleepEntries.map { $0.duration }.max() ?? 0
    }
    var worstSleep: Double {
        sleepEntries.map { $0.duration }.min() ?? 0
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Edge-to-edge gradient background: Indigo to Blue.
                LinearGradient(
                    gradient: Gradient(colors: [Color.indigo.opacity(0.3), Color.blue.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        // MARK: - Time Range Picker
                        Picker("Time Range", selection: $selectedTimeRange) {
                            ForEach(timeRanges, id: \.self) { range in
                                Text(range).tag(range)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                        
                        // MARK: - Sleep Duration Chart
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Sleep Duration")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            Chart {
                                ForEach(sleepEntries) { entry in
                                    LineMark(
                                        x: .value("Date", entry.date),
                                        y: .value("Duration (hrs)", entry.duration)
                                    )
                                    .foregroundStyle(Color.green)
                                    .symbol(Circle())
                                }
                            }
                            .frame(height: 200)
                            .padding(.horizontal)
                        }
                        
                        // MARK: - Statistics Summary
                        HStack(spacing: 16) {
                            StatItemView(title: "Avg Sleep", value: String(format: "%.1f hrs", averageSleep))
                            StatItemView(title: "Best", value: String(format: "%.1f hrs", bestSleep))
                            StatItemView(title: "Worst", value: String(format: "%.1f hrs", worstSleep))
                        }
                        .padding(.horizontal)
                        
                        Divider()
                            .padding(.horizontal)
                        
                        // MARK: - Sleep Entries List
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(sleepEntries) { entry in
                                Button(action: {
                                    // Optionally, navigate to a detailed view for this entry.
                                }) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(entry.date, style: .date)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                            Text(String(format: "%.1f hrs", entry.duration))
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            if let note = entry.note, !note.isEmpty {
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
                        }
                        .padding(.horizontal)
                        
                        // MARK: - Export / Share Report Button
                        Button(action: {
                            // Implement export/share functionality.
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Export/Share Report")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                } // ScrollView
            } // ZStack
            .navigationTitle("Sleep History")
        } // NavigationView
    }
}

// MARK: - Supporting Data Model

struct SleepEntry: Identifiable {
    let id = UUID()
    let date: Date
    let duration: Double // Duration in hours.
    let note: String?
}

// MARK: - Preview

struct SleepHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        SleepHistoryView()
    }
}

