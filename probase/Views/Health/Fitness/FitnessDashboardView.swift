//
//  FitnessDashboardView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/5/25.
//
import SwiftUI
import Charts

struct FitnessDashboardView: View {
    // Dummy data for the mini trend chart
    let trendData: [ActivityData] = [
        ActivityData(time: "6 AM", steps: 1000),
        ActivityData(time: "7 AM", steps: 2000),
        ActivityData(time: "8 AM", steps: 3000),
        ActivityData(time: "9 AM", steps: 4000),
        ActivityData(time: "10 AM", steps: 3500),
        ActivityData(time: "11 AM", steps: 4200)
    ]
    
    // Example activity metrics
    let currentSteps: Int = 8000
    let targetSteps: Int = 10000
    let calories: Int = 500
    let activeMinutes: Int = 45
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.orange.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Title
                        Text("Today's Activity")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding(.top)
                        
                        // Ring Gauge for Steps
                        RingGaugeView(progress: Double(currentSteps) / Double(targetSteps), centerText: "\(currentSteps)/\(targetSteps) steps")
                            .frame(width: 200, height: 200)
                        
                        // Key Stats Row
                        HStack(spacing: 16) {
                            StatTileViewFitness(title: "Steps", value: "\(currentSteps)")
                            StatTileViewFitness(title: "Calories", value: "\(calories) kcal")
                            StatTileViewFitness(title: "Active", value: "\(activeMinutes) min")
                        }
                        .padding(.horizontal)
                        
                        // Mini Trend Chart (Activity Trend)
                        VStack(alignment: .leading) {
                            Text("Activity Trend")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                            
                            Chart(trendData) { data in
                                LineMark(
                                    x: .value("Time", data.time),
                                    y: .value("Steps", data.steps)
                                )
                                .foregroundStyle(Color.green)
                            }
                            .frame(height: 150)
                            .padding(.horizontal)
                        }
                        
                        // Quick Action Buttons Row
                        HStack(spacing: 16) {
                            QuickActionButtonView(title: "Start Workout", systemImageName: "figure.walk")
                            QuickActionButtonView(title: "Log Activity", systemImageName: "pencil")
                            QuickActionButtonView(title: "History", systemImageName: "clock.arrow.circlepath")
                            QuickActionButtonView(title: "Settings", systemImageName: "gearshape")
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Fitness")
        }
    }
}

// MARK: - Data Model for Trend Chart

struct ActivityData: Identifiable {
    let id = UUID()
    let time: String
    let steps: Int
}

// MARK: - Ring Gauge View

struct RingGaugeView: View {
    /// A value between 0 and 1.
    var progress: Double
    var centerText: String
    
    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 20)
            // Progress circle
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [Color.blue, Color.green]),
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 1.0), value: progress)
            // Center text
            Text(centerText)
                .font(.headline)
                .foregroundColor(.primary)
        }
    }
}

// MARK: - Stat Tile View

struct StatTileViewFitness: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground).opacity(0.8))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

// MARK: - Quick Action Button View

struct QuickActionButtonViewFitness: View {
    var title: String
    var systemImageName: String
    
    var body: some View {
        Button(action: {
            // Define action for each button
        }) {
            VStack(spacing: 4) {
                Image(systemName: systemImageName)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue.opacity(0.7))
                    .clipShape(Circle())
                Text(title)
                    .font(.footnote)
                    .foregroundColor(.primary)
            }
            .padding()
            .background(Color(.systemBackground).opacity(0.9))
            .cornerRadius(12)
            .shadow(radius: 2)
        }
    }
}

// MARK: - Preview Provider

struct FitnessDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        FitnessDashboardView()
            .environment(\.colorScheme, .light)
    }
}

