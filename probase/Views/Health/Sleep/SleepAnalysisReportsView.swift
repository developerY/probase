//
//  SleepAnalysisReportsView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/4/25.
//
import SwiftUI
import Charts

struct SleepAnalysisReportsView: View {
    // Dummy data for sleep cycle breakdown (in percentages)
    let sleepCycleData: [SleepCycleSegment] = [
        SleepCycleSegment(cycle: "Light", percentage: 50, color: .blue),
        SleepCycleSegment(cycle: "Deep", percentage: 30, color: .green),
        SleepCycleSegment(cycle: "REM", percentage: 20, color: .purple)
    ]
    
    // Dummy data for sleep consistency over time (e.g., sleep efficiency)
    let consistencyData: [SleepConsistency] = [
        SleepConsistency(date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, efficiency: 80),
        SleepConsistency(date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, efficiency: 82),
        SleepConsistency(date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, efficiency: 85),
        SleepConsistency(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, efficiency: 87),
        SleepConsistency(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, efficiency: 84),
        SleepConsistency(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, efficiency: 86),
        SleepConsistency(date: Date(), efficiency: 88)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Edge-to-edge gradient background: Purple to Black
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.4), Color.black.opacity(0.6)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header Title
                        Text("Sleep Analysis & Reports")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top)
                        
                        // Sleep Cycle Breakdown Pie Chart
                        VStack {
                            Text("Sleep Cycle Breakdown")
                                .font(.headline)
                                .foregroundColor(.white)
                            PieChartView(segments: sleepCycleData)
                                .frame(width: 200, height: 200)
                        }
                        
                        // Sleep Consistency Line Chart
                        VStack(alignment: .leading) {
                            Text("Sleep Consistency Over Time")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            Chart {
                                ForEach(consistencyData) { data in
                                    LineMark(
                                        x: .value("Date", data.date),
                                        y: .value("Efficiency (%)", data.efficiency)
                                    )
                                    .foregroundStyle(Color.yellow)
                                    .symbol(Circle())
                                }
                            }
                            // Customize the X-axis labels if needed.
                            .chartXAxis {
                                AxisMarks(values: .automatic) { value in
                                    AxisValueLabel(format: .dateTime.day().month(), centered: true)
                                }
                            }
                            .frame(height: 200)
                            .padding(.horizontal)
                        }
                        
                        // Insights Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Insights")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Your sleep efficiency improved by 5% this month!")
                                .font(.body)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.horizontal)
                        
                        // Generate Detailed Report Button
                        Button(action: {
                            // Implement the report generation functionality here.
                        }) {
                            Text("Generate Detailed Report")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                } // ScrollView
            } // ZStack
            .navigationTitle("Sleep Analysis")
        } // NavigationView
    }
}

// MARK: - Supporting Data Models

struct SleepCycleSegment: Identifiable {
    let id = UUID()
    let cycle: String
    let percentage: Double
    let color: Color
}

struct SleepConsistency: Identifiable {
    let id = UUID()
    let date: Date
    let efficiency: Double
}

// MARK: - PieChartView Implementation

struct PieChartView: View {
    let segments: [SleepCycleSegment]
    
    var body: some View {
        GeometryReader { geometry in
            let width = min(geometry.size.width, geometry.size.height)
            let radius = width / 2
            let center = CGPoint(x: geometry.size.width/2, y: geometry.size.height/2)
            let total = segments.reduce(0) { $0 + $1.percentage }
            var startAngle = Angle(degrees: -90)
            
            ZStack {
                ForEach(segments) { segment in
                    let angle = Angle(degrees: (segment.percentage / total) * 360)
                    Path { path in
                        path.move(to: center)
                        path.addArc(center: center,
                                    radius: radius,
                                    startAngle: startAngle,
                                    endAngle: startAngle + angle,
                                    clockwise: false)
                    }
                    .fill(segment.color)
                    startAngle += angle
                }
            }
        }
    }
}

// MARK: - Preview

struct SleepAnalysisReportsView_Previews: PreviewProvider {
    static var previews: some View {
        SleepAnalysisReportsView()
            .environment(\.colorScheme, .dark)
    }
}

