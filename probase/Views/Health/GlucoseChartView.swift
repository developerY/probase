//
//  GlucoseChartView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI
import Charts

struct GlucoseChartView: View {
    @EnvironmentObject var dataStore: DiabetesDataStore
    
    var body: some View {
        // If you only support iOS 16+:
        Chart {
            createChartContent()
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
                //AxisValueLabel(format: .number.precision(.fractionLength(1)))
            }
        }
        .chartScrollableAxes(.horizontal)
        //.chartZoom(.automatic)
        .frame(height: 200)
        .padding()
    }

    /// Breaks up the large code block into a separate function
    @ChartContentBuilder
    private func createChartContent() -> some ChartContent {
        // Historical glucose
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
        
        // Predicted
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
}
