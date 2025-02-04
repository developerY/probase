//
//  WorkoutActivityView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/3/25.
//
import SwiftUI

struct WorkoutActivityView: View {
    // MARK: - State Properties
    @State private var isWorkoutActive: Bool = false
    @State private var liveHR: Int = 150  // Dummy live heart rate value
    @State private var averageHR: Int = 140
    @State private var maxHR: Int = 155
    
    // Dummy zones data: each zone with the number of minutes spent in that zone.
    let zoneData: [WorkoutZone] = [
        WorkoutZone(name: "Fat Burn", duration: 10),
        WorkoutZone(name: "Cardio", duration: 25),
        WorkoutZone(name: "Peak", duration: 5)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Use a different background—a soft teal color with slight opacity
                RadialGradient(
                    gradient: Gradient(colors: [Color.red.opacity(0.3), Color.blue.opacity(0.3)]),
                    center: .center,
                    startRadius: 100,
                    endRadius: 500
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header Title
                        Text("Workout Mode")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        // Live Heart Rate Display
                        VStack(spacing: 8) {
                            Text("Live HR:")
                                .font(.headline)
                            Text("\(liveHR) BPM")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.red)
                            // Display current zone label
                            Text("Cardio Zone")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        // Zone Breakdown Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Zones Breakdown")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            // Loop over each zone to display a horizontal bar chart
                            ForEach(zoneData) { zone in
                                HStack {
                                    Text(zone.name)
                                        .frame(width: 80, alignment: .leading)
                                    
                                    GeometryReader { geometry in
                                        ZStack(alignment: .leading) {
                                            // Background bar
                                            RoundedRectangle(cornerRadius: 8)
                                                .frame(height: 20)
                                                .foregroundColor(Color.gray.opacity(0.2))
                                            
                                            // Foreground bar (width proportional to duration)
                                            RoundedRectangle(cornerRadius: 8)
                                                .frame(width: CGFloat(zone.duration) * 5, height: 20)
                                                .foregroundColor(colorForZone(zone.name))
                                        }
                                    }
                                    .frame(height: 20)
                                    
                                    Text("\(zone.duration) min")
                                        .frame(width: 60, alignment: .trailing)
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        // Stats Section: Average and Maximum Heart Rate
                        HStack(spacing: 16) {
                            StatItemView(title: "Avg HR", value: "\(averageHR) BPM")
                            StatItemView(title: "Max HR", value: "\(maxHR) BPM")
                        }
                        .padding(.horizontal)
                        
                        // Workout Control Buttons
                        HStack(spacing: 16) {
                            Button(action: {
                                // Start workout action
                                isWorkoutActive = true
                            }) {
                                Text("Start Workout")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(isWorkoutActive ? Color.gray : Color.green)
                                    .cornerRadius(12)
                            }
                            .disabled(isWorkoutActive)
                            
                            Button(action: {
                                // End workout action
                                isWorkoutActive = false
                            }) {
                                Text("End Workout")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(!isWorkoutActive ? Color.gray : Color.red)
                                    .cornerRadius(12)
                            }
                            .disabled(!isWorkoutActive)
                        }
                        .padding(.horizontal)
                    } // VStack
                    .padding(.vertical)
                } // ScrollView
            } // ZStack
            .navigationTitle("Workout")
        } // NavigationView
    }
    
    // Helper function to assign colors based on the zone name
    private func colorForZone(_ zone: String) -> Color {
        switch zone {
        case "Fat Burn":
            return Color.green
        case "Cardio":
            return Color.orange
        case "Peak":
            return Color.red
        default:
            return Color.blue
        }
    }
}

// Data model for a workout zone
struct WorkoutZone: Identifiable {
    let id = UUID()
    let name: String
    let duration: Int // Duration in minutes spent in this zone
}

// A reusable view for displaying a statistic item

struct WorkoutActivityView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutActivityView()
    }
}

