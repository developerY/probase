import SwiftUI

// MARK: - Data Models
import Foundation

struct GlucoseDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    var level: Double // Glucose level in mmol/L
    var trendArrow: String? // e.g., "↑", "↓", "→"
    
    init(date: Date, level: Double) {
        self.date = date
        self.level = level
        self.trendArrow = GlucoseDataPoint.calculateTrend(for: level)
    }
    
    static func calculateTrend(for level: Double) -> String {
        // Example logic for determining trend based on glucose level thresholds
        if level > 8.5 {
            return "↑" // High trend
        } else if level < 4.0 {
            return "↓" // Low trend
        } else {
            return "→" // Stable trend
        }
    }
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
    var type: String
    var durationInMinutes: Int
    var intensity: String
}

struct MealDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    var mealType: String
    var description: String
    var carbs: Double
}

struct NotificationEvent: Identifiable {
    let id = UUID()
    let date: Date
    var type: String
    var message: String
    var acknowledged: Bool
}

struct DeviceData: Identifiable {
    let id = UUID()
    var deviceName: String
    var batteryLevel: Double?
    var lastSyncDate: Date?
    var status: String
}

struct GlucoseTrend {
    let period: String
    var averageGlucose: Double
    var highestGlucose: Double
    var lowestGlucose: Double
    var timeInRange: Double
}

struct UserProfile {
    let id = UUID()
    var name: String
    var age: Int
    var typeOfDiabetes: String
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
        startLiveUpdates()
    }

    // MARK: - Helper Methods for Mock Data
    private func generateExerciseData() -> [ExerciseDataPoint] {
        (0..<10).map { _ in
            ExerciseDataPoint(
                date: Date().addingTimeInterval(Double.random(in: -7 * 24 * 60 * 60 ... 0)),
                type: ["Walking", "Running", "Yoga"].randomElement()!,
                durationInMinutes: Int.random(in: 15...90),
                intensity: ["Low", "Moderate", "High"].randomElement()!
            )
        }
    }

    private func generateMealData() -> [MealDataPoint] {
        (0..<5).map { _ in
            MealDataPoint(
                date: Date().addingTimeInterval(Double.random(in: -7 * 24 * 60 * 60 ... 0)),
                mealType: ["Breakfast", "Lunch", "Dinner", "Snack"].randomElement()!,
                description: ["Oatmeal", "Grilled Chicken", "Salad"].randomElement()!,
                carbs: Double.random(in: 20...80)
            )
        }
    }

    private func generateNotificationEvents() -> [NotificationEvent] {
        (0..<3).map { _ in
            NotificationEvent(
                date: Date().addingTimeInterval(Double.random(in: -24 * 60 * 60 ... 0)),
                type: ["High Glucose Alert", "Low Glucose Alert"].randomElement()!,
                message: "Glucose out of range!",
                acknowledged: Bool.random()
            )
        }
    }
    
    
    private func startLiveUpdates() {
        Task {
            while true {
                await updateGlucoseData()
                try? await Task.sleep(nanoseconds: 5_000_000_000)  // Sleep for 5 seconds
            }
        }
    }

    @MainActor
    private func updateGlucoseData() {
        let newPoint = GlucoseDataPoint(date: Date(), level: Double.random(in: 4.5...9.5))
        glucoseData.append(newPoint)
        glucoseData = glucoseData.suffix(100)  // Limit data points
    }

    private func generateTrend(period: String, days: Int) -> GlucoseTrend {
        let filteredData = glucoseData.filter { $0.date > Date().addingTimeInterval(-Double(days * 24 * 60 * 60)) }
        let avgGlucose = filteredData.map(\.level).reduce(0, +) / Double(filteredData.count)
        return GlucoseTrend(
            period: period,
            averageGlucose: avgGlucose,
            highestGlucose: filteredData.map(\.level).max() ?? 0.0,
            lowestGlucose: filteredData.map(\.level).min() ?? 0.0,
            timeInRange: calculateTimeInRange()
        )
    }

    // MARK: - Mock Data Generation
    private func generateMockData() {
        let now = Date()
        lastUpdate = now

        // Generate 7 days of data, every 15 minutes
        for i in 0..<(7 * 24 * 4) {
            let offset = TimeInterval(-15 * 60 * i)
            let date = now.addingTimeInterval(offset)

            glucoseData.append(GlucoseDataPoint(date: date, level: Double.random(in: 4.5...9.5)))
            if i < 12 {
                predictedGlucoseData.append(
                    PredictedGlucoseDataPoint(
                        date: now.addingTimeInterval(TimeInterval(15 * 60 * i)),
                        predictedLevel: 5.0 + Double.random(in: -0.5...0.5)
                    )
                )
            }
            activeInsulinData.append(ActiveInsulinDataPoint(date: date, units: Double.random(in: 0.0...1.0)))
            insulinDeliveryData.append(InsulinDeliveryDataPoint(date: date, deliveredUnits: Double.random(in: 0.0...1.5)))
            carbData.append(CarbDataPoint(date: date, grams: Double.random(in: 0.0...25.0)))
        }

        generateAdditionalMockData()
        sortAllData()
    }

    private func generateAdditionalMockData() {
        exerciseData = generateExerciseData()
        mealData = generateMealData()
        notificationEvents = generateNotificationEvents()
        connectedDevices = [
            DeviceData(deviceName: "Dexcom G6", batteryLevel: Double.random(in: 20...100), lastSyncDate: Date(), status: "Connected"),
            DeviceData(deviceName: "OmniPod", batteryLevel: Double.random(in: 10...100), lastSyncDate: Date().addingTimeInterval(-3 * 60 * 60), status: "Disconnected")
        ]
        glucoseTrends = [
            generateTrend(period: "Last 7 Days", days: 7),
            generateTrend(period: "Last 24 Hours", days: 1)
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
        for i in glucoseData.indices {
            glucoseData[i].level = Double.random(in: 4.5...9.5)
        }

        for i in predictedGlucoseData.indices {
            predictedGlucoseData[i].predictedLevel = 5.0 + Double.random(in: -0.5...0.5)
        }

        for i in activeInsulinData.indices {
            activeInsulinData[i].units = Double.random(in: 0.0...1.0)
        }

        for i in insulinDeliveryData.indices {
            insulinDeliveryData[i].deliveredUnits = Double.random(in: 0.0...1.5)
        }

        for i in carbData.indices {
            carbData[i].grams = Double.random(in: 0.0...25.0)
        }

        exerciseData = generateExerciseData()
        mealData = generateMealData()
        currentGlucose = Double.random(in: 4.5...9.5)
        predictedGlucose = Double.random(in: 4.5...9.5)
        activeInsulin = Double.random(in: 0.0...2.0)
        carbsOnBoard = Double.random(in: 0.0...30.0)
        lastUpdate = Date()
    }
}
