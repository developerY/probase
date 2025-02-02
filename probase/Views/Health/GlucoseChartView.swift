//
//  GlucoseChartView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI
import Charts

struct GlucoseChartView: View {
    @EnvironmentObject var dataStore: GlucoseDataStore

    var body: some View {
        
            Chart {
                // Use the entire 7 days or filter to last 24 hours if you want
                ForEach(dataStore.glucoseData) { point in
                    LineMark(
                        x: .value("Time", point.date),    // X = Date
                        y: .value("Glucose", point.level) // Y = Numeric
                    )
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic) {
                    AxisGridLine()
                    // Format dates on X
                    AxisValueLabel(format: .dateTime.day().hour().minute())
                }
            }
            .chartYAxis {
                AxisMarks(values: .automatic) {
                    AxisGridLine()
                    // Format numeric on Y
                    // AxisValueLabel(format: .number.precision(.fractionLength(1)))
                }
            }
            .frame(height: 300)
            .padding()
       
    }
}

