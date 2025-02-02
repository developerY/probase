//
//  HomeDashboardView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI

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
                        Label("Current Glucose", systemImage: "heart.fill")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(String(format: "%.1f", dataStore.currentGlucose)) mmol/L")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.blue)
                        Label("Trending \(dataStore.glucoseData.last?.trendArrow ?? "→")", systemImage: "arrow.up.right")
                            .font(.headline)
                            .foregroundColor(.orange)
                    }
                    .padding()
                    .background(Color.cyan.opacity(0.3))
                    .cornerRadius(12)

                    // Key Stats with SF Symbols
                    HStack(spacing: 16) {
                        DashboardStatView(
                            title: "Time in Range",
                            value: "72%",
                            symbol: "clock.fill",
                            backgroundColor: Color.green.opacity(0.3)
                        )
                        DashboardStatView(
                            title: "Active Insulin",
                            value: "\(String(format: "%.2f", dataStore.activeInsulin)) U",
                            symbol: "syringe.fill",
                            backgroundColor: Color.yellow.opacity(0.3)
                        )
                        DashboardStatView(
                            title: "Carbs On Board",
                            value: "\(Int(dataStore.carbsOnBoard)) g",
                            symbol: "leaf.fill",
                            backgroundColor: Color.purple.opacity(0.3)
                        )
                    }

                    // Mini Trend Chart with expandable header
                    dashboardHeader(
                        title: "Mini Trend Chart",
                        systemImage: "chart.line.uptrend.xyaxis",
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
                        systemImage: "chart.bar.xaxis",
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
                            Label("Add Meal", systemImage: "fork.knife.circle.fill")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.orange)
                    }
                    .padding()
                }
                .padding()
                .background(Color(UIColor.systemGroupedBackground))
            }
            .navigationTitle("Dashboard")
        }
    }

    // MARK: - Dashboard Header with Expand/Collapse Chevron
    private func dashboardHeader(title: String, systemImage: String, isExpanded: Binding<Bool>) -> some View {
        HStack {
            Label(title, systemImage: systemImage)
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
    let symbol: String
    let backgroundColor: Color

    var body: some View {
        VStack {
            Label(title, systemImage: symbol)
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
