//
//  DiabetesDataStore.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI
import Charts

/// Represents a single glucose data point
struct GlucoseDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    var level: Double // e.g., 5.8 mmol/L
}

/// Represents a predicted glucose data point
struct PredictedGlucoseDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    var predictedLevel: Double
}

/// Represents active insulin over time
struct ActiveInsulinDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    var units: Double // e.g. 0.13 U
}

/// Represents insulin delivery over time
struct InsulinDeliveryDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    var deliveredUnits: Double
}

/// Represents carbohydrate data over time
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

    /// Populates the store with some mock data
    private func generateMockData() {
        let now = Date()
        lastUpdate = now

        // Generate 7 days of data, every 15 minutes
        for i in 0..<(7 * 24 * 4) {
            let offset = TimeInterval(-15 * 60 * i)
            let date = now.addingTimeInterval(offset)


            // Random-ish glucose
            let glucoseLevel = Double.random(in: 4.5...9.5)
            glucoseData.append(GlucoseDataPoint(date: date, level: glucoseLevel))

            // Random predicted values for next 3 hours
            if i < 12 {
                let predictedDate = now.addingTimeInterval(TimeInterval(15 * 60 * i))
                let predictedLevel = 5.0 + Double.random(in: -0.5...0.5)
                predictedGlucoseData.append(
                    PredictedGlucoseDataPoint(date: predictedDate, predictedLevel: predictedLevel)
                )
            }

            // Simulate active insulin
            let active = Double.random(in: 0.0...1.0)
            activeInsulinData.append(ActiveInsulinDataPoint(date: date, units: active))

            // Simulate insulin delivery
            let delivered = Double.random(in: 0.0...1.5)
            insulinDeliveryData.append(InsulinDeliveryDataPoint(date: date, deliveredUnits: delivered))

            // Simulate carbs
            let carbs = Double.random(in: 0.0...25.0)
            carbData.append(CarbDataPoint(date: date, grams: carbs))
        }

        // Sort data oldest to newest
        glucoseData.sort(by: { $0.date < $1.date })
        predictedGlucoseData.sort(by: { $0.date < $1.date })
        activeInsulinData.sort(by: { $0.date < $1.date })
        insulinDeliveryData.sort(by: { $0.date < $1.date })
        carbData.sort(by: { $0.date < $1.date })
    }
}

extension DiabetesDataStore {
    /// Randomize only the numeric values (levels, units, etc.), keep dates sorted.
    func shuffleAllData() {
        // Randomize the glucose "level" only
        for i in glucoseData.indices {
            glucoseData[i].level = Double.random(in: 4.5...9.5)
        }
        
        // Randomize the predicted "predictedLevel"
        for i in predictedGlucoseData.indices {
            predictedGlucoseData[i].predictedLevel = 5.0 + Double.random(in: -0.5...0.5)
        }
        
        // Randomize the active insulin "units"
        for i in activeInsulinData.indices {
            activeInsulinData[i].units = Double.random(in: 0.0...1.0)
        }
        
        // Randomize insulin delivery "deliveredUnits"
        for i in insulinDeliveryData.indices {
            insulinDeliveryData[i].deliveredUnits = Double.random(in: 0.0...1.5)
        }
        
        // Randomize carb "grams"
        for i in carbData.indices {
            carbData[i].grams = Double.random(in: 0.0...25.0)
        }
        
        // Because we never touched the 'date' field, each array remains chronologically sorted.

        // Randomize top-level numbers
        currentGlucose = Double.random(in: 4.5...9.5)
        predictedGlucose = Double.random(in: 4.5...9.5)
        activeInsulin = Double.random(in: 0.0...2.0)
        carbsOnBoard = Double.random(in: 0.0...30.0)
        lastUpdate = Date()
    }
}



