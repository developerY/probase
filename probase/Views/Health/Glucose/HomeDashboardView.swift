//
//  HomeDashboardView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI

// MARK: - Colors Extension
extension Color {
    static let pastelBlue = Color(red: 0.7, green: 0.85, blue: 1.0)
    static let pastelGreen = Color(red: 0.75, green: 1.0, blue: 0.75)
    static let pastelYellow = Color(red: 1.0, green: 1.0, blue: 0.75)
    static let pastelPink = Color(red: 1.0, green: 0.8, blue: 0.85)
    static let pastelPurple = Color(red: 0.85, green: 0.75, blue: 1.0)
    static let pastelMint = Color(red: 0.75, green: 1.0, blue: 0.9)
}


struct HomeDashboardView: View {
    @EnvironmentObject var dataStore: GlucoseDataStore

    // State variables to control graph visibility
    @State private var isMiniTrendChartExpanded = true
    @State private var isDashboardTrendChartExpanded = true

    var body: some View {
        NavigationStack {
            ZStack {
                // Softer Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.4), .green.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Current Glucose Card
                        VStack(spacing: 8) {
                            Label {
                                Text("Current Glucose")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            } icon: {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            }

                            Text("\(String(format: "%.1f", dataStore.currentGlucose)) mmol/L")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.primary)

                            Text("Trending \(dataStore.glucoseData.last?.trendArrow ?? "→")")
                                .font(.headline)
                                .foregroundColor(.orange)
                        }
                        .padding()
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .padding(.horizontal)

                        // Key Stats
                        HStack(spacing: 16) {
                            DashboardStatView(title: "Time in Range", value: "72%", icon: "clock.fill", color: .green)
                            DashboardStatView(title: "Active Insulin", value: "\(String(format: "%.2f", dataStore.activeInsulin)) U", icon: "drop.fill", color: .yellow)
                            DashboardStatView(title: "Carbs On Board", value: "\(Int(dataStore.carbsOnBoard)) g", icon: "leaf.fill", color: .pink)
                        }
                        .padding(.horizontal)

                        // Mini Trend Chart with header
                        dashboardHeader(
                            title: "Mini Trend Chart",
                            isExpanded: $isMiniTrendChartExpanded,
                            backgroundColor: Color.purple.opacity(0.4) // Use your desired pastel color
                        )
                        if isMiniTrendChartExpanded {
                            MiniTrendChartView()
                                .environmentObject(dataStore)
                                .transition(.slide)
                        }

                        // Dashboard Trend Chart with header
                        dashboardHeader(
                            title: "Dashboard Trend Chart",
                            isExpanded: $isDashboardTrendChartExpanded,
                            backgroundColor: Color.teal.opacity(0.4) // Use a different pastel color for variety
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
                            .tint(.blue)

                            Button(action: {}) {
                                Label("Add Meal", systemImage: "fork.knife.circle")
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Dashboard")
        }
    }

    // MARK: - Dashboard Header with Expand/Collapse Chevron and Custom Background Color
    private func dashboardHeader(title: String, isExpanded: Binding<Bool>, backgroundColor: Color) -> some View {
        HStack {
            Image(systemName: title == "Mini Trend Chart" ? "chart.line.uptrend.xyaxis" : "chart.bar.doc.horizontal")
                .font(.headline)
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: isExpanded.wrappedValue ? "chevron.up" : "chevron.down")
                .font(.headline)
                .foregroundColor(.white)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isExpanded.wrappedValue.toggle()
                    }
                }
        }
        .padding(12)
        .background(backgroundColor)
        .cornerRadius(12)
    }

}

// MARK: - DashboardStatView
struct DashboardStatView: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack {
            Label(title, systemImage: icon)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(color.opacity(0.3))
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
