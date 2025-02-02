//
//  MiniTrendChartView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI
import Charts

struct MiniTrendChartView: View {
    @EnvironmentObject var dataStore: GlucoseDataStore

    var body: some View {
        Chart {
            ForEach(dataStore.glucoseData) { point in
                LineMark(
                    x: .value("Time", point.date),
                    y: .value("Glucose Level", point.level)
                )
                .foregroundStyle(Color.blue)
                .symbol(.circle)
                .symbolSize(8)
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .hour, count: 6)) { value in
                AxisValueLabel(format: .dateTime.hour().minute())
            }
        }
        .chartYAxis {
            AxisMarks(values: .automatic) { value in
                AxisGridLine()
                AxisValueLabel()
                /*
                 AxisValueLabel {
                             if let yValue = value.as(Double.self) {
                                 Text("\(yValue, specifier: "%.1f")")  // Manually specify the number format
                             }
                         }
                 */
            }
        }
        .frame(height: 150)
        .padding()
    }
}

// MARK: - Preview
struct MiniTrendChartView_Previews: PreviewProvider {
    static var previews: some View {
        MiniTrendChartView()
            .environmentObject(GlucoseDataStore())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

