//
//  HomeDashboardView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI

struct HomeDashboardView: View {
    @EnvironmentObject var dataStore: GlucoseDataStore

    // State variables to control graph visibility
    @State private var isMiniTrendChartExpanded = true
    @State private var isDashboardTrendChartExpanded = true

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {

                    // Current Glucose
                    VStack {
                        Text("Current Glucose")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(String(format: "%.1f", dataStore.currentGlucose)) mmol/L")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.blue)
                        Text("Trending \(dataStore.glucoseData.last?.trendArrow ?? "→")")
                            .font(.headline)
                            .foregroundColor(.orange)
                    }
                    .padding()
                    .background(Color.cyan.opacity(0.2))
                    .cornerRadius(12)

                    // Key Stats
                    HStack(spacing: 16) {
                        DashboardStatView(
                            title: "Time in Range",
                            value: "72%",
                            backgroundColor: Color.green.opacity(0.3)
                        )
                        DashboardStatView(
                            title: "Active Insulin",
                            value: "\(String(format: "%.2f", dataStore.activeInsulin)) U",
                            backgroundColor: Color.yellow.opacity(0.3)
                        )
                        DashboardStatView(
                            title: "Carbs On Board",
                            value: "\(Int(dataStore.carbsOnBoard)) g",
                            backgroundColor: Color.purple.opacity(0.3)
                        )
                    }

                    // Mini Trend Chart with expandable header
                    dashboardHeader(
                        title: "Mini Trend Chart",
                        isExpanded: $isMiniTrendChartExpanded
                    )
                    if isMiniTrendChartExpanded {
                        MiniTrendChartView()
                            .environmentObject(dataStore)
                            .transition(.slide)
                    }

                    // Dashboard Trend Chart with expandable header
                    dashboardHeader(
                        title: "Dashboard Trend Chart",
                        isExpanded: $isDashboardTrendChartExpanded
                    )
                    if isDashboardTrendChartExpanded {
                        DashboardTrendChartViewOld()
                            .environmentObject(dataStore)
                            .transition(.slide)
                    }

                    // Quick Actions
                    HStack(spacing: 16) {
                        Button(action: {}) {
                            Label("Log BG", systemImage: "drop.fill")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.blue)

                        Button(action: {}) {
                            Label("Add Meal", systemImage: "fork.knife.circle")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.orange)
                    }
                    .padding()
                }
                .padding()
            }
            .navigationTitle("Dashboard")
        }
    }

    // MARK: - Dashboard Header with Expand/Collapse Chevron
    private func dashboardHeader(title: String, isExpanded: Binding<Bool>) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: isExpanded.wrappedValue ? "chevron.up" : "chevron.down")
                .foregroundColor(.secondary)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isExpanded.wrappedValue.toggle()
                    }
                }
        }
        .padding(12)
        .background(Color.indigo.opacity(0.2))
        .cornerRadius(12)
    }
}

// MARK: - DashboardStatView
struct DashboardStatView: View {
    let title: String
    let value: String
    let backgroundColor: Color

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
        .background(backgroundColor)
        .cornerRadius(12)
    }
}

// MARK: - Preview
struct HomeDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeDashboardView()
                .environmentObject(GlucoseDataStore())
                .previewDisplayName("Light Mode")

            HomeDashboardView()
                .environmentObject(GlucoseDataStore())
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
        }
    }
}

