//
//  GlucoseMonitorView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI

struct GlucoseMonitorView: View {
    @State private var glucoseLevel: Double = 110.0  // Example starting value
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        VStack(spacing: 20) {
            // SF Symbol representing health data (use appropriate symbol for glucose)
            Image(systemName: "drop.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)

            Text("Glucose Monitor")
                .font(.largeTitle)
                .bold()

            // Display glucose reading
            Text("\(Int(glucoseLevel)) mg/dL")
                .font(.title)
                .padding()

            // Slider to simulate glucose level changes (for demo purposes)
            Slider(value: $glucoseLevel, in: 40...300, step: 1.0)
                .padding()
                .onChange(of: glucoseLevel) { newValue in
                    checkGlucoseLevel(newValue)
                }

            // Buttons for manual alerts (for demo purposes)
            HStack {
                Button("Simulate Low Glucose") {
                    simulateLowGlucose()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)

                Button("Simulate High Glucose") {
                    simulateHighGlucose()
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Glucose Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    // Check glucose level and show alerts if needed
    private func checkGlucoseLevel(_ level: Double) {
        if level < 70 {
            alertMessage = "Low Glucose Detected! (\(Int(level)) mg/dL)"
            showAlert = true
        } else if level > 180 {
            alertMessage = "High Glucose Detected! (\(Int(level)) mg/dL)"
            showAlert = true
        }
    }

    // Simulate low glucose manually
    private func simulateLowGlucose() {
        glucoseLevel = 65
        checkGlucoseLevel(glucoseLevel)
    }

    // Simulate high glucose manually
    private func simulateHighGlucose() {
        glucoseLevel = 200
        checkGlucoseLevel(glucoseLevel)
    }
}

// MARK: - SwiftUI Preview
struct GlucoseMonitorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GlucoseMonitorView()
                .previewDisplayName("Default Preview")
                .previewDevice("iPhone 15 Pro")

            GlucoseMonitorView()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode Preview")
        }
    }
}
