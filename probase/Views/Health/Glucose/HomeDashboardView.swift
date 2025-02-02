//
//  HomeDashboardView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI

struct HomeDashboardView: View {
    @EnvironmentObject var dataStore: DiabetesDataStore

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

                    // Key Stats
                    HStack(spacing: 16) {
                        DashboardStatView(title: "Time in Range", value: "72%")
                        DashboardStatView(title: "Active Insulin", value: "\(String(format: "%.2f", dataStore.activeInsulin)) U")
                        DashboardStatView(title: "Carbs On Board", value: "\(Int(dataStore.carbsOnBoard)) g")
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

    // MARK: - Dashboard Header with Expand/Collapse Chevron
    private func dashboardHeader(title: String, isExpanded: Binding<Bool>) -> some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Image(systemName: isExpanded.wrappedValue ? "chevron.up" : "chevron.down")
                .foregroundColor(.secondary)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isExpanded.wrappedValue.toggle()
                    }
                }
        }
        .padding(8)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
    }
}

// MARK: - DashboardStatView
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
