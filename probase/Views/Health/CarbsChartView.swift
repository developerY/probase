//
//  CarbsChartView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI
import Charts

struct CarbsChartView: View {
    @EnvironmentObject var dataStore: GlucoseDataStore
    
    var body: some View {
        Group {
          
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
                .chartScrollableAxes(.horizontal)
                //.chartZoom(.)
                .frame(height: 120)
                .padding()
           
        }
    }
}

