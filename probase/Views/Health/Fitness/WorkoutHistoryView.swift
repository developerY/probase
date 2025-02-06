//
//  WorkoutHistoryView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/5/25.
//
import SwiftUI
import Charts

struct WorkoutHistoryView: View {
    // MARK: - State Properties
    let timeRanges = ["Day", "Week", "Month", "Custom"]
    @State private var selectedTimeRange = "Week"
    
    // Dummy workout entries
    let workoutEntries: [WorkoutEntry] = [
        WorkoutEntry(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, workoutType: "Running", duration: 30, calories: 300),
        WorkoutEntry(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, workoutType: "Cycling", duration: 45, calories: 400),
        WorkoutEntry(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, workoutType: "HIIT", duration: 20, calories: 250)
    ]
    
    // Computed properties for summary stats.
    var totalCalories: Int {
        workoutEntries.reduce(0) { $0 + $1.calories }
    }
    
    var averageDuration: Double {
        guard !workoutEntries.isEmpty else { return 0 }
        return Double(workoutEntries.reduce(0) { $0 + $1.duration }) / Double(workoutEntries.count)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.2), Color.blue.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Header Section with Title and Segmented Control
                        VStack(spacing: 8) {
                            Text("Workout History")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top)
                            
                            Picker("Time Range", selection: $selectedTimeRange) {
                                ForEach(timeRanges, id: \.self) { range in
                                    Text(range).tag(range)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.horizontal)
                        }
                        
                        // Summary Stats Row using StatTileViewFitness
                        HStack(spacing: 16) {
                            StatTileViewFitness(title: "Total Workouts", value: "\(workoutEntries.count)")
                            StatTileViewFitness(title: "Avg Duration", value: String(format: "%.0f min", averageDuration))
                            StatTileViewFitness(title: "Total Calories", value: "\(totalCalories) kcal")
                        }
                        .padding(.horizontal)
                        
                        // Workout Trend Chart
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Weekly Workout Trends")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            Chart {
                                ForEach(workoutEntries) { entry in
                                    LineMark(
                                        x: .value("Date", entry.date),
                                        y: .value("Duration (min)", entry.duration)
                                    )
                                    .foregroundStyle(Color.orange)
                                    .symbol(Circle())
                                }
                            }
                            .frame(height: 200)
                            .padding(.horizontal)
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
                        // List of Workout Entries
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(workoutEntries) { entry in
                                Button(action: {
                                    // Optionally navigate to detailed view
                                }) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(entry.date, style: .date)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                            Text("\(entry.workoutType) - \(entry.duration) min")
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                        }
                                        Spacer()
                                        Text("\(entry.calories) kcal")
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
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
                        
                        // Export/Share Report Button
                        Button(action: {
                            // Implement export/share functionality here.
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
                        .padding(.bottom)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Workout History")
        }
    }
}

// MARK: - Data Model for Workout Entry

struct WorkoutEntry: Identifiable {
    let id = UUID()
    let date: Date
    let workoutType: String
    let duration: Int  // in minutes
    let calories: Int
}

// MARK: - Reusable Stat Tile for Fitness (StatTileViewFitness)



// MARK: - Preview Provider

struct WorkoutHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutHistoryView()
            .environment(\.colorScheme, .light)
    }
}

