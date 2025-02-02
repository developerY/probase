//
//  DashboardTrendChartView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI
import Charts

import SwiftUI
import Charts

struct DashboardTrendChartView: View {
    @EnvironmentObject var dataStore: DiabetesDataStore

    var body: some View {
        Chart(dataStore.glucoseData) { point in
            LineMark(
                x: .value("Time", point.date),
                y: .value("Glucose Level", point.level)
            )
            .symbol(by: .value("Trend", point.trendArrow ?? "→"))
                        .symbol { _ in
                            Circle() // Simplifying by always using Circle for now
                        }
                        .foregroundStyle(.blue) // Apply a simple style
                        .lineStyle(StrokeStyle(lineWidth: 2))
            }
            .lineStyle(StrokeStyle(lineWidth: 2))
        }
        .chartXAxis {
            AxisMarks(values: .automatic) { _ in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.hour().minute(), centered: true)
            }
        }
        .chartYAxis {
            AxisMarks(values: .automatic) { _ in
                AxisGridLine()
                AxisValueLabel(format: .number.precision(.fractionLength(1)))
            }
        }
        .frame(height: 200)
        .padding()
    }
}


struct DashboardTrendChartView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTrendChartView()
            .environmentObject(DiabetesDataStore())
            .previewDevice("iPhone 14 Pro")
    }
}

