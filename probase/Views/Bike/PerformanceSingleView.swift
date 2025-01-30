//
//  PerformanceSingleView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/29/25.
//
import SwiftUI

struct PerformanceSingleView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.6), .green.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        Text("Performance Tuning")
                            .font(.largeTitle.weight(.bold))
                            .foregroundColor(.white)

                        // Display all three cards on the screen
                        SuspensionTuningCard(tabColor: .blue)
                        GearingTuningCard(tabColor: .green)
                        BrakeMonitoringCard(tabColor: .red)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

// MARK: - Suspension
private struct SuspensionTuningCard: View {
    @State private var riderWeight: Double = 70
    @State private var currentMode: String = "Comfort"
    let tabColor: Color
    @State private var shake = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Animated Bike Icon
            Image(systemName: "bicycle")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .foregroundColor(tabColor)
                .offset(x: shake ? -8 : 8, y: shake ? -4 : 4)
                .rotationEffect(.degrees(shake ? -5 : 5))
                .animation(
                    Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true),
                    value: shake
                )
                .onAppear {
                    shake = true
                }

            Text("Suspension Setup")
                .font(.headline)

            HStack {
                Text("Rider Weight: \(Int(riderWeight)) kg")
                Slider(value: $riderWeight, in: 50...120, step: 1)
                    .tint(tabColor)
            }

            Picker("Mode", selection: $currentMode) {
                ForEach(["Comfort", "Sport", "Off-Road"], id: \.self) { mode in
                    Text(mode)
                        .foregroundColor(currentMode == mode ? .white : tabColor)
                        .padding()
                        .background(currentMode == mode ? tabColor : Color.clear)
                        .cornerRadius(8)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Button("Apply Settings") {}
                .buttonStyle(.borderedProminent)
                .foregroundColor(.white)
                .tint(tabColor)
        }
        .padding()
        .background(tabColor.opacity(0.15).cornerRadius(12))
        .shadow(radius: 5)
    }
}

// MARK: - Gearing
private struct GearingTuningCard: View {
    @State private var autoShiftEnabled = true
    @State private var targetCadence: Double = 85
    let tabColor: Color
    @State private var rotateGear = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Animated Rotating Gear Icon
            Image(systemName: "gear")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .rotationEffect(.degrees(rotateGear ? 360 : 0))
                .animation(
                    Animation.linear(duration: 2.0).repeatForever(autoreverses: false),
                    value: rotateGear
                )
                .onAppear {
                    rotateGear = true
                }

            Text("Gearing Optimization")
                .font(.headline)

            Toggle("Enable Auto-Shifting", isOn: $autoShiftEnabled)
                .toggleStyle(SwitchToggleStyle(tint: tabColor))

            HStack {
                Text("Target Cadence: \(Int(targetCadence)) rpm")
                Slider(value: $targetCadence, in: 60...120, step: 5)
                    .tint(tabColor)
            }

            Button("Apply Gear Settings") {}
                .buttonStyle(.borderedProminent)
                .foregroundColor(.white)
                .tint(tabColor)
        }
        .padding()
        .background(tabColor.opacity(0.15).cornerRadius(12))
        .shadow(radius: 5)
    }
}

// MARK: - Brakes
private struct BrakeMonitoringCard: View {
    @State private var brakeSensitivity: Double = 0.5
    let tabColor: Color
    @State private var brakePulse = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Animated Pulsing Speedometer Icon
            Image(systemName: "speedometer")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .scaleEffect(brakePulse ? 1.4 : 1.0)
                .animation(
                    Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                    value: brakePulse
                )
                .onAppear {
                    brakePulse = true
                }

            Text("Brake Monitoring")
                .font(.headline)

            Text("Current Sensitivity: \(String(format: "%.1f", brakeSensitivity))")
            Slider(value: $brakeSensitivity, in: 0...1)
                .tint(tabColor)

            Button("Calibrate Brakes") {}
                .buttonStyle(.borderedProminent)
                .foregroundColor(.white)
                .tint(tabColor)
        }
        .padding()
        .background(tabColor.opacity(0.15).cornerRadius(12))
        .shadow(radius: 5)
    }
}

#Preview {
    PerformanceSingleView()
}

