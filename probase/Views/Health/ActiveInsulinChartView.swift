//
//  ActiveInsulinChartView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI
import Charts

struct ActiveInsulinChartView: View {
    @EnvironmentObject var dataStore: GlucoseDataStore
    
    var body: some View {
        Group {
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
        }
    }
}

