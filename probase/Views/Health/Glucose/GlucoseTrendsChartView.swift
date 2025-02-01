//
//  GlucoseTrendsChartView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI
import Charts

struct GlucoseTrendsChartView: View {
    @EnvironmentObject var dataStore: DiabetesDataStore

    var body: some View {
        Chart {
            ForEach(dataStore.glucoseTrends, id: \.period) { trend in
                BarMark(
                    x: .value("Period", trend.period),
                    y: .value("Average Glucose", trend.averageGlucose)
                )
                .foregroundStyle(Color.blue)

                LineMark(
                    x: .value("Period", trend.period),
                    y: .value("Highest Glucose", trend.highestGlucose)
                )
                .foregroundStyle(Color.red)
            }
        }
        .frame(height: 200)
        .padding()
    }
}
