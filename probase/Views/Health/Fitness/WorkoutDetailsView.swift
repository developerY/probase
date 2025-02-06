//
//  WorkoutDetailsView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/5/25.
//
import SwiftUI
import Charts

struct WorkoutDetailsView: View {
    // Dummy data for heart rate chart during the workout.
    let heartRateData: [HeartRatePoint] = [
        HeartRatePoint(time: 0, rate: 80),
        HeartRatePoint(time: 5, rate: 110),
        HeartRatePoint(time: 10, rate: 130),
        HeartRatePoint(time: 15, rate: 140),
        HeartRatePoint(time: 20, rate: 135),
        HeartRatePoint(time: 25, rate: 120),
        HeartRatePoint(time: 30, rate: 100)
    ]
    
    // Workout session details.
    var workoutType: String = "Running"
    var workoutDate: Date = Date()
    var duration: Int = 30     // in minutes
    var calories: Int = 300
    var avgHeartRate: Int = 120
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient: from soft red to light orange.
                LinearGradient(
                    gradient: Gradient(colors: [Color.red.opacity(0.2), Color.orange.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header: Workout type and date.
                        VStack(spacing: 8) {
                            Text(workoutType)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            Text(workoutDate, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top)
                        
                        // Summary Metrics using StatTileViewFitness.
                        HStack(spacing: 16) {
                            StatTileViewFitness(title: "Duration", value: "\(duration) min")
                            StatTileViewFitness(title: "Calories", value: "\(calories) kcal")
                            StatTileViewFitness(title: "Avg HR", value: "\(avgHeartRate) bpm")
                        }
                        .padding(.horizontal)
                        
                        // Heart Rate Chart during Workout.
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Heart Rate Over Time")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            Chart(heartRateData) { point in
                                LineMark(
                                    x: .value("Time (min)", point.time),
                                    y: .value("Heart Rate", point.rate)
                                )
                                .foregroundStyle(Color.red)
                                .symbol(Circle())
                            }
                            .frame(height: 200)
                            .padding(.horizontal)
                        }
                        
                        // Additional Workout Details Section.
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Workout Details")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            Text("This workout was a steady run focusing on endurance. Your pace was consistent throughout the session, and you maintained a good average heart rate. Keep up the excellent work!")
                                .font(.body)
                                .padding(.horizontal)
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Workout Details")
        }
    }
}

// MARK: - Supporting Data Model for Heart Rate Points

struct HeartRatePoint: Identifiable {
    let id = UUID()
    let time: Int   // Minutes from the start of the workout.
    let rate: Int   // Heart rate in beats per minute.
}



// MARK: - Preview Provider

struct WorkoutDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailsView()
            .environment(\.colorScheme, .light)
    }
}

