//
//  SleepDashboardView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/4/25.
//
import SwiftUI
import Charts

struct SleepDashboardView: View {
    // Dummy sleep cycle data for the chart (durations in hours)
    let sleepData: [SleepCycleData] = [
        SleepCycleData(cycle: "Light", duration: 3.5),
        SleepCycleData(cycle: "Deep", duration: 2.0),
        SleepCycleData(cycle: "REM", duration: 1.5)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Edge-to-edge gradient background: Midnight Blue to Purple
                LinearGradient(
                    gradient: Gradient(colors: [Color("MidnightBlue"), Color.purple.opacity(0.5)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Top Section: Sleep Overview
                        VStack(spacing: 8) {
                            Text("Last Night's Sleep")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            HStack(alignment: .center, spacing: 5) {
                                Text("7.5 hrs")
                                    .font(.system(size: 48, weight: .bold))
                                    .foregroundColor(.white)
                                Image(systemName: "moon.stars.fill")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(.yellow)
                            }
                            
                            Text("Good Sleep")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.horizontal)
                        
                        // Key Sleep Metrics Row
                        HStack(spacing: 16) {
                            SleepMetricTileView(title: "Efficiency", value: "85%")
                            SleepMetricTileView(title: "Time in Bed", value: "8 hrs")
                            SleepMetricTileView(title: "Latency", value: "15 min")
                        }
                        .padding(.horizontal)
                        
                        // Graphical Snapshot: Sleep Cycle Breakdown Chart
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Sleep Cycles")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            Chart {
                                ForEach(sleepData) { data in
                                    // Use a BarMark to show the duration for each cycle.
                                    BarMark(
                                        x: .value("Cycle", data.cycle),
                                        y: .value("Duration", data.duration)
                                    )
                                    .foregroundStyle(by: .value("Cycle", data.cycle))
                                }
                            }
                            .frame(height: 200)
                            .padding(.horizontal)
                        }
                        
                        // Quick Action Buttons Row
                        HStack(spacing: 16) {
                            SleepQuickActionButtonView(title: "Sleep History", systemImageName: "clock")
                            SleepQuickActionButtonView(title: "Log Sleep", systemImageName: "pencil")
                            SleepQuickActionButtonView(title: "Analysis", systemImageName: "chart.bar.doc.horizontal")
                            SleepQuickActionButtonView(title: "Settings", systemImageName: "gearshape")
                        }
                        .padding(.horizontal)
                    } // VStack
                    .padding(.vertical)
                } // ScrollView
            } // ZStack
            .navigationTitle("Sleep Tracker")
        } // NavigationView
    }
}

// MARK: - Supporting Data Model

struct SleepCycleData: Identifiable {
    let id = UUID()
    let cycle: String
    let duration: Double
}

// MARK: - Reusable Metric Tile View

struct SleepMetricTileView: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
            Text(value)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
    }
}

// MARK: - Reusable Quick Action Button View

struct SleepQuickActionButtonView: View {
    var title: String
    var systemImageName: String
    
    var body: some View {
        Button(action: {
            // Implement the quick action here.
        }) {
            VStack(spacing: 4) {
                Image(systemName: systemImageName)
                    .font(.title2)
                    .padding(8)
                    .background(Color.white.opacity(0.2))
                    .clipShape(Circle())
                Text(title)
                    .font(.footnote)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .cornerRadius(12)
        }
    }
}

// MARK: - Preview

struct SleepDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        // If you haven't defined "MidnightBlue" in your asset catalog, replace it below.
        SleepDashboardView()
            .environment(\.colorScheme, .dark) // Optional: preview in dark mode
    }
}

