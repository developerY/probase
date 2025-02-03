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


import SwiftUI

struct HomeDashboardView: View {
    @EnvironmentObject var dataStore: GlucoseDataStore

    // State variables to control graph visibility
    @State private var isMiniTrendChartExpanded = true
    @State private var isDashboardTrendChartExpanded = true

    // Animation states
    @State private var isPulsing = false
    @State private var isPressed = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient with animation
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.4), .green.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                //.animation(.linear(duration: 10).repeatForever(autoreverses: true), value: isPulsing)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Current Glucose
                        VStack {
                        
                            // Animated pulsing heart icon
                            HStack {
                                Image(systemName: "drop.fill")
                                    .foregroundColor(.red)
                                    .scaleEffect(isPulsing ? 1.2 : 1.0)
                                    //.animation(.easeInOut(duration: 0.8).repeatForever(), value: isPulsing)
                                
                                
                                Text("Current Glucose")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }.onAppear { isPulsing = true }

                            Text("\(String(format: "%.1f", dataStore.currentGlucose)) mmol/L")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("Trending \(dataStore.glucoseData.last?.trendArrow ?? "→")")
                                .font(.headline)
                                .foregroundColor(.orange)
                        }
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(12)

                        // Key Stats
                        HStack(spacing: 16) {
                            DashboardStatView(title: "Time in Range", value: "72%", icon: "clock")
                            DashboardStatView(title: "Active Insulin", value: "\(String(format: "%.2f", dataStore.activeInsulin)) U", icon: "syringe")
                            DashboardStatView(title: "Carbs On Board", value: "\(Int(dataStore.carbsOnBoard)) g", icon: "leaf.fill")
                        }

                        // Mini Trend Chart with expandable header
                        dashboardHeader(
                            title: "Mini Trend Chart",
                            icon: "chart.line.uptrend.xyaxis",
                            isExpanded: $isMiniTrendChartExpanded,
                            backgroundColor: Color.purple.opacity(0.4)
                        )
                        if isMiniTrendChartExpanded {
                            MiniTrendChartView()
                                .environmentObject(dataStore)
                                .transition(.slide)
                        }

                        // Dashboard Trend Chart with expandable header
                        dashboardHeader(
                            title: "Dashboard Trend Chart",
                            icon: "rectangle.stack.fill",
                            isExpanded: $isDashboardTrendChartExpanded,
                            backgroundColor: Color.teal.opacity(0.4)
                        )
                        if isDashboardTrendChartExpanded {
                            DashboardTrendChartViewOld()
                                .environmentObject(dataStore)
                                .transition(.slide)
                        }

                        // Quick Actions with hover animation
                        HStack(spacing: 16) {
                            Button(action: {}) {
                                Label("Log BG", systemImage: "drop.fill")
                            }
                            .tint(.orange)
                            .buttonStyle(.borderedProminent)
                            .scaleEffect(isPressed ? 0.95 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isPressed)
                            /*.onLongPressGesture(minimumDuration: 0.1) {
                                isPressed = true
                            } onRelease: {
                                isPressed = false
                            }*/

                            Button(action: {}) {
                                Label("Add Meal", systemImage: "fork.knife.circle")
                            }
                            .tint(.cyan)
                            .buttonStyle(.borderedProminent)
                            .scaleEffect(isPressed ? 0.95 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isPressed)
                        }
                    }
                    .padding()
                }
                .navigationTitle("Dashboard")
            }
        }
    }

    // MARK: - Dashboard Header with Expand/Collapse Chevron Animation
    private func dashboardHeader(title: String, icon: String, isExpanded: Binding<Bool>,  backgroundColor: Color) -> some View {
        HStack {
            Label(title, systemImage: icon)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: isExpanded.wrappedValue ? "chevron.down" : "chevron.up")
                .foregroundColor(.white)
                //.rotationEffect(.degrees(isExpanded.wrappedValue ? 0 : 180))
                //.transition(.move(edge: .top))
                //.animation(.easeInOut(duration: 0.3), value: isExpanded.wrappedValue)
                .onTapGesture {
                    //withAnimation(.smooth) {
                    isExpanded.wrappedValue.toggle()
                    //}
                }
        }
        .padding(12)
        .background(backgroundColor) // Color.blue.opacity(0.5)
        .cornerRadius(12)
    }
}

// MARK: - DashboardStatView with Icon
struct DashboardStatView: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(.secondary)
                .font(.system(size: 24))

            Text(title)
                .font(.caption)
                .foregroundColor(.primary)

            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.green.opacity(0.5))
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
