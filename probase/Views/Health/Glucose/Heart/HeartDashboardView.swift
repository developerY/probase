//
//  HeartDashboardView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/3/25.
//
import SwiftUI
import Charts

struct HeartDashboardView: View {
    // Dummy data for the recent 6h trend sparkline
    let heartRateData: [HeartRateData] = [
        HeartRateData(time: "6 AM", rate: 65),
        HeartRateData(time: "7 AM", rate: 70),
        HeartRateData(time: "8 AM", rate: 72),
        HeartRateData(time: "9 AM", rate: 75),
        HeartRateData(time: "10 AM", rate: 74),
        HeartRateData(time: "11 AM", rate: 73)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    
                    // Current Heart Rate Display
                    VStack(spacing: 8) {
                        HStack(alignment: .center, spacing: 5) {
                            Text("72 BPM")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.primary)
                            // Trend indicator using SF Symbol; change "arrow.up" as needed
                            Image(systemName: "arrow.up")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.green)
                        }
                        Text("Current Heart Rate")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    // Mini ECG waveform using an SF Symbol
                    Image(systemName: "waveform.path.ecg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                    
                    // (Optional) Alert Banner: Uncomment to display if needed.
                    /*
                    Text("High Heart Rate Alert!")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange.opacity(0.3))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    */
                    
                    // Key Stats Row: Avg HR, Resting HR, HRV
                    HStack(spacing: 16) {
                        StatTileView(iconName: "heart.fill", title: "Avg HR", value: "68 BPM")
                        StatTileView(iconName: "bed.double.fill", title: "Resting", value: "60 BPM")
                        StatTileView(iconName: "waveform.path.ecg", title: "HRV", value: "50 ms")
                    }
                    .padding(.horizontal)
                    
                    // Sparkline Chart for Recent Heart Rate Trends
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Recent Trends")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        Chart {
                            ForEach(heartRateData) { data in
                                LineMark(
                                    x: .value("Time", data.time),
                                    y: .value("Rate", data.rate)
                                )
                                .foregroundStyle(Color.blue)
                            }
                        }
                        // Hide axes for a cleaner sparkline look
                        .chartXAxis(.hidden)
                        .chartYAxis(.hidden)
                        .frame(height: 100)
                        .padding(.horizontal)
                    }
                    
                    // Quick Action Buttons Row
                    HStack(spacing: 16) {
                        QuickActionButtonView(title: "History", systemImageName: "clock.arrow.circlepath")
                        QuickActionButtonView(title: "Log Event", systemImageName: "pencil")
                        QuickActionButtonView(title: "Workout", systemImageName: "figure.walk")
                        QuickActionButtonView(title: "Settings", systemImageName: "gearshape")
                    }
                    .padding(.horizontal)
                } // VStack
                .padding(.vertical)
                .navigationTitle("Heart Monitor")
            } // ScrollView
        } // NavigationView
    }
}

// MARK: - Supporting Models and Views

// Dummy data model for the sparkline chart
struct HeartRateData: Identifiable {
    let id = UUID()
    let time: String
    let rate: Int
}

// A reusable view for each stat tile
struct StatTileView: View {
    var iconName: String
    var title: String
    var value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: iconName)
                .font(.title)
                .foregroundColor(.red)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(value)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// A reusable view for quick action buttons
struct QuickActionButtonView: View {
    var title: String
    var systemImageName: String
    
    var body: some View {
        Button(action: {
            // Add button action here.
        }) {
            VStack(spacing: 4) {
                Image(systemName: systemImageName)
                    .font(.title2)
                    .padding(8)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(Circle())
                Text(title)
                    .font(.footnote)
                    .foregroundColor(.primary)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}

// MARK: - Preview

struct HeartDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        HeartDashboardView()
    }
}

