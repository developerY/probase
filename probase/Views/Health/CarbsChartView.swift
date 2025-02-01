//
//  CarbsChartView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI
import Charts

struct CarbsChartView: View {
    @EnvironmentObject var dataStore: DiabetesDataStore
    
    var body: some View {
        Group {
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
        }
    }
}

