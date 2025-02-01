//
//  DiabetesDataStore.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI
import Charts

// MARK: - Data Models
struct GlucoseDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    var level: Double // e.g., mmol/L
}

struct PredictedGlucoseDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    var predictedLevel: Double
}

struct ActiveInsulinDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    var units: Double
}

struct InsulinDeliveryDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    var deliveredUnits: Double
}

struct CarbDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    var grams: Double
}

/// Mock data store managing all diabetes-related data
class DiabetesDataStore: ObservableObject {
    @Published var glucoseData: [GlucoseDataPoint] = []
    @Published var predictedGlucoseData: [PredictedGlucoseDataPoint] = []
    @Published var activeInsulinData: [ActiveInsulinDataPoint] = []
    @Published var insulinDeliveryData: [InsulinDeliveryDataPoint] = []
    @Published var carbData: [CarbDataPoint] = []

    // For display at the top of the screen
    @Published var lastUpdate: Date?
    @Published var currentGlucose: Double = 5.8
    @Published var predictedGlucose: Double = 5.5
    @Published var activeInsulin: Double = 0.13
    @Published var insulinOnBoard: Double = 0.0
    @Published var carbsOnBoard: Double = 0.0

    init() {
        generateMockData()
    }

    /// Populates the store with 7 days of data, every 15 minutes
    private func generateMockData() {
        let now = Date()
        lastUpdate = now

        // 7 days * 24 hours/day * 4 intervals/hour = 672 data points
        for i in 0..<(7 * 24 * 4) {
            // Each increment goes 15 minutes further into the past
            let offset = TimeInterval(-15 * 60 * i)
            let date = now.addingTimeInterval(offset)

            // Random-ish glucose reading
            let glucoseLevel = Double.random(in: 4.5...9.5)
            glucoseData.append(GlucoseDataPoint(date: date, level: glucoseLevel))

            // Random predicted values for the first 3 hours (12 intervals)
            if i < 12 {
                let futureDate = now.addingTimeInterval(TimeInterval(15 * 60 * i))
                let predictedLevel = 5.0 + Double.random(in: -0.5...0.5)
                predictedGlucoseData.append(
                    PredictedGlucoseDataPoint(date: futureDate, predictedLevel: predictedLevel)
                )
            }

            // Simulated active insulin
            let active = Double.random(in: 0.0...1.0)
            activeInsulinData.append(ActiveInsulinDataPoint(date: date, units: active))

            // Simulated insulin delivery
            let delivered = Double.random(in: 0.0...1.5)
            insulinDeliveryData.append(InsulinDeliveryDataPoint(date: date, deliveredUnits: delivered))

            // Simulated carbs
            let carbs = Double.random(in: 0.0...25.0)
            carbData.append(CarbDataPoint(date: date, grams: carbs))
        }

        // Sort all arrays from oldest-to-newest date
        glucoseData.sort(by: { $0.date < $1.date })
        predictedGlucoseData.sort(by: { $0.date < $1.date })
        activeInsulinData.sort(by: { $0.date < $1.date })
        insulinDeliveryData.sort(by: { $0.date < $1.date })
        carbData.sort(by: { $0.date < $1.date })
    }
}

// MARK: - Shuffle Numeric Values
extension DiabetesDataStore {
    /// Randomize only the numeric fields (levels, units, etc.), keep dates sorted.
    func shuffleAllData() {
        // Glucose
        for i in glucoseData.indices {
            glucoseData[i].level = Double.random(in: 4.5...9.5)
        }
        
        // Predicted
        for i in predictedGlucoseData.indices {
            predictedGlucoseData[i].predictedLevel = 5.0 + Double.random(in: -0.5...0.5)
        }
        
        // Active insulin
        for i in activeInsulinData.indices {
            activeInsulinData[i].units = Double.random(in: 0.0...1.0)
        }
        
        // Insulin delivery
        for i in insulinDeliveryData.indices {
            insulinDeliveryData[i].deliveredUnits = Double.random(in: 0.0...1.5)
        }
        
        // Carbs
        for i in carbData.indices {
            carbData[i].grams = Double.random(in: 0.0...25.0)
        }
        
        // Randomize top-level summary fields
        currentGlucose = Double.random(in: 4.5...9.5)
        predictedGlucose = Double.random(in: 4.5...9.5)
        activeInsulin = Double.random(in: 0.0...2.0)
        carbsOnBoard = Double.random(in: 0.0...30.0)
        lastUpdate = Date()
    }
}
