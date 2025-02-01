//
//  InsulinDeliveryChartView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI
import Charts

struct InsulinDeliveryChartView: View {
    @EnvironmentObject var dataStore: DiabetesDataStore
    
    var body: some View {
        Group {
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
        }
    }
}

