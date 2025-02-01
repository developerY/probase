//
//  DiabetesDataStore.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI

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

struct ExerciseDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    var type: String // e.g., "Walking", "Running"
    var durationInMinutes: Int
    var intensity: String // e.g., "Low", "Moderate", "High"
}

struct MealDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    var mealType: String // e.g., "Breakfast", "Snack"
    var description: String
    var carbs: Double
}

struct NotificationEvent: Identifiable {
    let id = UUID()
    let date: Date
    var type: String // e.g., "High Glucose Alert"
    var message: String
    var acknowledged: Bool
}

struct DeviceData: Identifiable {
    let id = UUID()
    var deviceName: String
    var batteryLevel: Double? // e.g., 80.0%
    var lastSyncDate: Date?
    var status: String // e.g., "Connected", "Disconnected"
}

struct GlucoseTrend {
    let period: String // e.g., "Last 7 Days"
    var averageGlucose: Double
    var highestGlucose: Double
    var lowestGlucose: Double
    var timeInRange: Double
}

struct UserProfile {
    let id: UUID = UUID()
    var name: String
    var age: Int
    var typeOfDiabetes: String // e.g., "Type 1", "Type 2"
    var targetRange: (min: Double, max: Double)
}

// MARK: - Diabetes Data Store
class DiabetesDataStore: ObservableObject {
    // Core Data
    @Published var glucoseData: [GlucoseDataPoint] = []
    @Published var predictedGlucoseData: [PredictedGlucoseDataPoint] = []
    @Published var activeInsulinData: [ActiveInsulinDataPoint] = []
    @Published var insulinDeliveryData: [InsulinDeliveryDataPoint] = []
    @Published var carbData: [CarbDataPoint] = []

    // Additional Features
    @Published var exerciseData: [ExerciseDataPoint] = []
    @Published var mealData: [MealDataPoint] = []
    @Published var notificationEvents: [NotificationEvent] = []
    @Published var connectedDevices: [DeviceData] = []
    @Published var glucoseTrends: [GlucoseTrend] = []

    // Top-Level Display Data
    @Published var lastUpdate: Date?
    @Published var currentGlucose: Double = 5.8
    @Published var predictedGlucose: Double = 5.5
    @Published var activeInsulin: Double = 0.13
    @Published var insulinOnBoard: Double = 0.0
    @Published var carbsOnBoard: Double = 0.0

    init() {
        generateMockData()
    }

    // MARK: - Mock Data Generation
    private func generateMockData() {
        let now = Date()
        lastUpdate = now

        // Generate 7 days of data, every 15 minutes
        for i in 0..<(7 * 24 * 4) {
            let offset = TimeInterval(-15 * 60 * i)
            let date = now.addingTimeInterval(offset)

            // Glucose Data
            glucoseData.append(GlucoseDataPoint(date: date, level: Double.random(in: 4.5...9.5)))

            // Predicted Glucose (for the first 3 hours)
            if i < 12 {
                predictedGlucoseData.append(
                    PredictedGlucoseDataPoint(
                        date: now.addingTimeInterval(TimeInterval(15 * 60 * i)),
                        predictedLevel: 5.0 + Double.random(in: -0.5...0.5)
                    )
                )
            }

            // Insulin and Carb Data
            activeInsulinData.append(ActiveInsulinDataPoint(date: date, units: Double.random(in: 0.0...1.0)))
            insulinDeliveryData.append(InsulinDeliveryDataPoint(date: date, deliveredUnits: Double.random(in: 0.0...1.5)))
            carbData.append(CarbDataPoint(date: date, grams: Double.random(in: 0.0...25.0)))
        }

        // Generate Mock Data for Other Features
        generateAdditionalMockData()

        // Sort all data
        sortAllData()
    }

    private func generateAdditionalMockData() {
        // Exercise Data
        exerciseData = (0..<10).map {
            ExerciseDataPoint(
                date: Date().addingTimeInterval(Double.random(in: -7 * 24 * 60 * 60 ... 0)),
                type: ["Walking", "Running", "Yoga"].randomElement()!,
                durationInMinutes: Int.random(in: 15...90),
                intensity: ["Low", "Moderate", "High"].randomElement()!
            )
        }

        // Meal Data
        mealData = (0..<5).map {
            MealDataPoint(
                date: Date().addingTimeInterval(Double.random(in: -7 * 24 * 60 * 60 ... 0)),
                mealType: ["Breakfast", "Lunch", "Dinner", "Snack"].randomElement()!,
                description: ["Oatmeal", "Grilled Chicken", "Salad"].randomElement()!,
                carbs: Double.random(in: 20...80)
            )
        }

        // Notifications
        notificationEvents = (0..<3).map {
            NotificationEvent(
                date: Date().addingTimeInterval(Double.random(in: -24 * 60 * 60 ... 0)),
                type: ["High Glucose Alert", "Low Glucose Alert"].randomElement()!,
                message: "Glucose out of range!",
                acknowledged: Bool.random()
            )
        }

        // Connected Devices
        connectedDevices = [
            DeviceData(deviceName: "Dexcom G6", batteryLevel: Double.random(in: 20...100), lastSyncDate: Date(), status: "Connected"),
            DeviceData(deviceName: "OmniPod", batteryLevel: Double.random(in: 10...100), lastSyncDate: Date().addingTimeInterval(-3 * 60 * 60), status: "Disconnected")
        ]

        // Glucose Trends
        let averageGlucose = glucoseData.map(\.level).reduce(0, +) / Double(glucoseData.count)
        glucoseTrends = [
            GlucoseTrend(
                period: "Last 7 Days",
                averageGlucose: averageGlucose,
                highestGlucose: glucoseData.map(\.level).max() ?? 0.0,
                lowestGlucose: glucoseData.map(\.level).min() ?? 0.0,
                timeInRange: calculateTimeInRange()
            )
        ]
    }

    private func sortAllData() {
        glucoseData.sort(by: { $0.date < $1.date })
        predictedGlucoseData.sort(by: { $0.date < $1.date })
        activeInsulinData.sort(by: { $0.date < $1.date })
        insulinDeliveryData.sort(by: { $0.date < $1.date })
        carbData.sort(by: { $0.date < $1.date })
    }

    private func calculateTimeInRange() -> Double {
        let inRange = glucoseData.filter { $0.level >= 4.0 && $0.level <= 10.0 }
        return (Double(inRange.count) / Double(glucoseData.count)) * 100.0
    }

    // MARK: - Shuffle Data for Testing
    func shuffleAllData() {
        // Shuffle core data values
        for i in glucoseData.indices {
            glucoseData[i].level = Double.random(in: 4.5...9.5)
        }
        // Shuffle additional data if needed
        generateAdditionalMockData()
    }
}
