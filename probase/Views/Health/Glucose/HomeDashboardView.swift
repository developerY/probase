//
//  HomeDashboardView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI

struct HomeDashboardView: View {
    @EnvironmentObject var dataStore: DiabetesDataStore
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // Current Glucose
                    VStack {
                        Text("Current Glucose")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("5.8 mmol/L")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.blue)
                        Text("Trending ↗︎")
                            .font(.headline)
                            .foregroundColor(.orange)
                    }

                    // Key Stats
                    HStack(spacing: 16) {
                        DashboardStatView(title: "Time in Range", value: "72%")
                        DashboardStatView(title: "Active Insulin", value: "0.15 U")
                        DashboardStatView(title: "Carbs On Board", value: "20 g")
                    }

                    // Mini Trend Chart (placeholder)
                    /*RoundedRectangle(cornerRadius: 8)
                        .fill(Color.blue.opacity(0.2))
                        .frame(height: 120)
                        .overlay(Text("Mini Trend Chart").foregroundColor(.blue))*/
                    
                    // Inside your DashboardView layout:
                    MiniTrendChartView()
                        .environmentObject(dataStore)


                    // Quick Actions
                    HStack(spacing: 16) {
                        Button(action: {}) {
                            Label("Log BG", systemImage: "drop.fill")
                        }
                        .buttonStyle(.borderedProminent)

                        Button(action: {}) {
                            Label("Add Meal", systemImage: "fork.knife.circle")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
            }
            .navigationTitle("Dashboard")
        }
    }
}

/// A small helper view for displaying a stat tile
struct DashboardStatView: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
    }
}

// MARK: - Preview
struct HomeDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeDashboardView()
                .environmentObject(DiabetesDataStore())
                .previewDisplayName("Light Mode")

            HomeDashboardView()
                .environmentObject(DiabetesDataStore())
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
        }
    }
}
