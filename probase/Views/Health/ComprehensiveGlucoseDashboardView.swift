//
//  ComprehensiveGlucoseDashboardView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI
import SwiftData
import Charts

struct ComprehensiveGlucoseDashboardView: View {
    @EnvironmentObject var dataStore: DiabetesDataStore

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // MARK: - HEADER (Key Info)
                    headerSection

                    // MARK: - GLUCOSE CHART
                    glucoseSection

                    // MARK: - ACTIVE INSULIN
                    activeInsulinSection

                    // MARK: - INSULIN DELIVERY
                    insulinDeliverySection

                    // MARK: - ACTIVE CARBS
                    carbSection
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Glucose Dashboard")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - HEADER
    private var headerSection: some View {
        VStack {
            HStack(alignment: .center, spacing: 16) {
                // Circle or ring to indicate recency
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color.green, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Text(timeAgoString())
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(String(format: "%.1f", dataStore.currentGlucose)) mmol/L")
                        .font(.title)
                        .bold()
                    Text("Eventually \(String(format: "%.1f", dataStore.predictedGlucose)) mmol/L")
                        .font(.subheadline)
                        .foregroundColor(.orange)
                }
                
                Spacer()
                
                // Pod Age or insulin on board
                VStack(alignment: .leading) {
                    Text("+\(String(format: "%.2f", dataStore.activeInsulin)) U")
                        .font(.headline)
                        .foregroundColor(.yellow)
                    Text("Active Insulin")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("\(String(format: "%.0f", dataStore.carbsOnBoard)) g")
                        .font(.headline)
                        .foregroundColor(.green)
                    Text("Active Carbs")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - GLUCOSE SECTION
    @ViewBuilder
    private var glucoseSection: some View {
        Section {
            if #available(iOS 16.0, *) {
                Chart {
                    // Historical glucose line
                    ForEach(dataStore.glucoseData) { point in
                        LineMark(
                            x: .value("Time", point.date),
                            y: .value("Glucose (mmol/L)", point.level)
                        )
                        .foregroundStyle(.blue)
                        
                        PointMark(
                            x: .value("Time", point.date),
                            y: .value("Glucose (mmol/L)", point.level)
                        )
                        .symbol(.circle)
                        .symbolSize(20)
                        .foregroundStyle(.blue)
                    }
                    
                    // Predicted glucose line (dashed)
                    ForEach(dataStore.predictedGlucoseData) { pred in
                        LineMark(
                            x: .value("Time", pred.date),
                            y: .value("Predicted (mmol/L)", pred.predictedLevel)
                        )
                        .foregroundStyle(.orange)
                        .interpolationMethod(.monotone)
                        .lineStyle(StrokeStyle(lineWidth: 2, dash: [4,4]))
                        
                        PointMark(
                            x: .value("Time", pred.date),
                            y: .value("Predicted (mmol/L)", pred.predictedLevel)
                        )
                        .symbol(.diamond)
                        .symbolSize(15)
                        .foregroundStyle(.orange)
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .automatic) { _ in
                        AxisGridLine()
                        AxisValueLabel(format: .dateTime.hour().minute())
                    }
                }
                .chartYAxis {
                    AxisMarks(values: .automatic) { _ in
                        AxisGridLine()
                        AxisValueLabel(format: Decimal.FormatStyle())//.number.precision(.fractionLength(1)))
                    }
                }
                .frame(height: 200)
                .padding()
            } else {
                Text("Charts require iOS 16 or newer.")
            }
        } header: {
            Text("Glucose")
                .font(.headline)
                .foregroundColor(.white)
                .padding(4)
                .background(Color.blue)
                .cornerRadius(4)
        }
    }
    
    // MARK: - ACTIVE INSULIN SECTION
    @ViewBuilder
    private var activeInsulinSection: some View {
        Section {
            if #available(iOS 16.0, *) {
                Chart {
                    ForEach(dataStore.activeInsulinData) { point in
                        AreaMark(
                            x: .value("Time", point.date),
                            y: .value("Active Insulin", point.units)
                        )
                        .foregroundStyle(
                            .linearGradient(
                                colors: [.orange.opacity(0.8), .orange.opacity(0.2)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    }
                }
                .frame(height: 120)
                .padding()
            } else {
                Text("Charts require iOS 16 or newer.")
            }
        } header: {
            Text("Active Insulin")
                .font(.headline)
                .foregroundColor(.white)
                .padding(4)
                .background(Color.orange)
                .cornerRadius(4)
        }
    }
    
    // MARK: - INSULIN DELIVERY SECTION
    @ViewBuilder
    private var insulinDeliverySection: some View {
        Section {
            if #available(iOS 16.0, *) {
                Chart {
                    ForEach(dataStore.insulinDeliveryData) { point in
                        BarMark(
                            x: .value("Time", point.date),
                            y: .value("Delivered (U)", point.deliveredUnits)
                        )
                        .foregroundStyle(.yellow)
                    }
                }
                .frame(height: 120)
                .padding()
            } else {
                Text("Charts require iOS 16 or newer.")
            }
        } header: {
            Text("Insulin Delivery")
                .font(.headline)
                .foregroundColor(.white)
                .padding(4)
                .background(Color.yellow)
                .cornerRadius(4)
        }
    }
    
    // MARK: - ACTIVE CARBS SECTION
    @ViewBuilder
    private var carbSection: some View {
        Section {
            if #available(iOS 16.0, *) {
                Chart {
                    ForEach(dataStore.carbData) { point in
                        LineMark(
                            x: .value("Time", point.date),
                            y: .value("Carbs (g)", point.grams)
                        )
                        .foregroundStyle(.green)
                        .interpolationMethod(.monotone)
                    }
                }
                .frame(height: 120)
                .padding()
            } else {
                Text("Charts require iOS 16 or newer.")
            }
        } header: {
            Text("Active Carbohydrates")
                .font(.headline)
                .foregroundColor(.white)
                .padding(4)
                .background(Color.green)
                .cornerRadius(4)
        }
    }
    
    // MARK: - UTILITY
    private func timeAgoString() -> String {
        guard let date = dataStore.lastUpdate else { return "--" }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

struct ComprehensiveGlucoseDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview in Light Mode on an iPhone 15 Pro
            ComprehensiveGlucoseDashboardView()
                .environmentObject(DiabetesDataStore())
                .previewDevice("iPhone 15 Pro")
                .previewDisplayName("iPhone 15 Pro - Light Mode")

            // Preview in Dark Mode on an iPhone SE (3rd generation)
            ComprehensiveGlucoseDashboardView()
                .environmentObject(DiabetesDataStore())
                .previewDevice("iPhone SE (3rd generation)")
                .preferredColorScheme(.dark)
                .previewDisplayName("iPhone SE (3rd gen) - Dark Mode")
        }
    }
}
