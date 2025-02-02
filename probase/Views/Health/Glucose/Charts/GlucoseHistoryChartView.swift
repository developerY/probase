//
//  GlucoseHistoryChart.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI
import Charts

// GlucoseHistoryChartView

struct GlucoseHistoryChartView: View {
    @EnvironmentObject var dataStore: DiabetesDataStore
    @State private var selectedRange: Int = 0  // 0: Day, 1: Week, 2: Month
    

    var body: some View {
        
        // Glucose History Chart
        Chart(filteredGlucoseData) { point in
            LineMark(
                x: .value("Time", point.date),
                y: .value("Glucose Level", point.level)
            )
            .symbol(by: .value("Trend", point.trendArrow))
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
                AxisValueLabel()
            }
        }
        .frame(height: 200)
        .padding()
    }
    
    
    // MARK: - Helper Methods
    private var filteredGlucoseData: [GlucoseDataPoint] {
        switch selectedRange {
        case 0:  // Day
            return dataStore.glucoseData.filter { $0.date > Calendar.current.date(byAdding: .day, value: -1, to: Date())! }
        case 1:  // Week
            return dataStore.glucoseData.filter { $0.date > Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())! }
        case 2:  // Month
            return dataStore.glucoseData.filter { $0.date > Calendar.current.date(byAdding: .month, value: -1, to: Date())! }
        default:
            return dataStore.glucoseData
        }
    }

    
    
    
}




// MARK: - Preview
struct GlucoseHistoryChartView_Previews: PreviewProvider {
    static var previews: some View {
        GlucoseHistoryChartView()
            .environmentObject(DiabetesDataStore())
    }
}

