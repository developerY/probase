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
                        Label {
                            Text("Current Glucose")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        } icon: {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }
                        .padding(.bottom, 4)

                        Text("\(String(format: "%.1f", dataStore.currentGlucose)) mmol/L")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.blue)

                        Text("Trending \(dataStore.glucoseData.last?.trendArrow ?? "→")")
                            .font(.headline)
                            .foregroundColor(.orange)
                    }
                    .padding()
                    .background(.blue.opacity(0.125))//Color("PastelBlue"))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Key Stats
                    HStack(spacing: 16) {
                        DashboardStatView(title: "Time in Range", value: "72%", icon: "clock.fill", color: .green)
                        DashboardStatView(title: "Active Insulin", value: "\(String(format: "%.2f", dataStore.activeInsulin)) U", icon: "syringe.fill", color: .yellow)
                        DashboardStatView(title: "Carbs On Board", value: "\(Int(dataStore.carbsOnBoard)) g", icon: "leaf.fill", color: .pink)
                    }
                    .padding(.horizontal)

                    // Mini Trend Chart with expandable header
                    dashboardHeader(
                        title: "Mini Trend Chart",
                        icon: "chart.line.uptrend.xyaxis",
                        isExpanded: $isMiniTrendChartExpanded
                    )
                    if isMiniTrendChartExpanded {
                        MiniTrendChartView()
                            .environmentObject(dataStore)
                            .transition(.slide)
                            .padding(.horizontal)
                    }

                    // Dashboard Trend Chart with expandable header
                    dashboardHeader(
                        title: "Dashboard Trend Chart",
                        icon: "chart.bar.fill",
                        isExpanded: $isDashboardTrendChartExpanded
                    )
                    if isDashboardTrendChartExpanded {
                        DashboardTrendChartViewOld()
                            .environmentObject(dataStore)
                            .transition(.slide)
                            .padding(.horizontal)
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
                .background(Color("PastelBackground"))
            }
            .navigationTitle("Dashboard")
        }
    }

    // MARK: - Dashboard Header with Expand/Collapse Chevron
    private func dashboardHeader(title: String, icon: String, isExpanded: Binding<Bool>) -> some View {
        HStack {
            Label(title, systemImage: icon)
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
        .background(Color("PastelHeader"))
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
        .background(color.opacity(0.2))
        .cornerRadius(12)
    }
}


// MARK: - Colors Extension
extension Color {
    static let pastelBlue = Color(red: 0.7, green: 0.85, blue: 1.0)
    static let pastelGreen = Color(red: 0.75, green: 1.0, blue: 0.75)
    static let pastelYellow = Color(red: 1.0, green: 1.0, blue: 0.75)
    static let pastelPink = Color(red: 1.0, green: 0.8, blue: 0.85)
    static let pastelPurple = Color(red: 0.85, green: 0.75, blue: 1.0)
    static let pastelMint = Color(red: 0.75, green: 1.0, blue: 0.9)
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
