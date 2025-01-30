//
//  PerformanceTuningView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/27/25.
//
import SwiftUI

struct PerformanceTuningView: View {
    @State private var selectedTab: TuningTab = .suspension

    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [selectedTab.color.opacity(0.6), Color.green.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Performance Tuning")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)

                    Picker("Performance Tabs", selection: $selectedTab) {
                        ForEach(TuningTab.allCases, id: \.self) { tab in
                            HStack {
                                /*Image(systemName: tab.icon)
                                    .symbolEffect(.pulse) // Add animation here
                                    .foregroundColor(tab.color)*/
                                Text(tab.title)
                            }
                            .tag(tab)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())


                    // Pass the color to each card
            
                    Group {
                        switch selectedTab {
                        case .suspension:
                            SuspensionTuningCard(tabColor: selectedTab.color)
                        case .gearing:
                            GearingTuningCard(tabColor: selectedTab.color)
                        case .brakes:
                            BrakeMonitoringCard(tabColor: selectedTab.color)
                        default:
                            EmptyView()  // Fallback to avoid type mismatch
                        }
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }
        }
    }
}


// MARK: - Tuning Tabs
enum TuningTab: CaseIterable {
    case suspension
    case gearing
    case brakes

    var title: String {
        switch self {
        case .suspension: return "Suspension"
        case .gearing: return "Gearing"
        case .brakes: return "Brakes"
        }
    }

    var icon: String {
        switch self {
        case .suspension: return "car.2.fill"
        case .gearing: return "gearshape.fill"
        case .brakes: return "speedometer"
        }
    }

    var color: Color {
        switch self {
        case .suspension: return .blue
        case .gearing: return .green
        case .brakes: return .red
        }
    }
}



// MARK: - Suspension
struct SuspensionTuningCard: View {
    @State private var riderWeight: Double = 70
    @State private var currentMode: String = "Comfort"
    let tabColor: Color
    @State private var shake = false


    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Animated icon

            Image(systemName: "bicycle")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .foregroundColor(tabColor)
                .offset(x: shake ? -8 : 8, y: shake ? -4 : 4)
                .rotationEffect(.degrees(shake ? -5 : 5))  // Add slight tilting
                .animation(
                    Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true),
                    value: shake
                )
                .onAppear {
                    shake = true
                }

            
            Text("Suspension Setup")
                .font(.headline)
                //.foregroundColor(tabColor)

            HStack {
                Text("Rider Weight: \(Int(riderWeight)) kg")
                    //.foregroundColor(tabColor)
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

            Button("Apply Settings") {
                // Send to suspension system
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(.white)
            .tint(tabColor)

            Spacer()
        }
        .padding()
        .background(tabColor.opacity(0.15).cornerRadius(12))
        .shadow(radius: 5)
    }
}



// MARK: - Gearing
struct GearingTuningCard: View {
    @State private var autoShiftEnabled = true
    @State private var targetCadence: Double = 85
    let tabColor: Color
    
    @State private var rotateGear = false


    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Animated icon
            Image(systemName: "gear")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                //.symbolEffect(.pulse)  // Add a pulsing effect
                //.background(tabColor)
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
                //.background(tabColor)

            Toggle("Enable Auto-Shifting", isOn: $autoShiftEnabled)
                .toggleStyle(SwitchToggleStyle(tint: tabColor))

            HStack {
                Text("Target Cadence: \(Int(targetCadence)) rpm")
                    //.background(tabColor)
                Slider(value: $targetCadence, in: 60...120, step: 5)
                    .tint(tabColor)
            }

            Button("Apply Gear Settings") {
                // Send to electronic drivetrain
            }
            .buttonStyle(.borderedProminent)
            //.foregroundColor(.white)
            .tint(tabColor)

            Spacer()
        }
        .padding()
        .background(tabColor.opacity(0.15).cornerRadius(12))
        .shadow(radius: 5)
    }
}



// MARK: - Brakes
struct BrakeMonitoringCard: View {
    @State private var brakeSensitivity: Double = 0.5
    let tabColor: Color
    
    @State private var brakePulse = false


    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Animated icon
            Image(systemName: "speedometer")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .symbolEffect(.scale)  // Add scale effect
                //.background(tabColor)
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
                //.foregroundColor(tabColor)

            Text("Current Sensitivity: \(String(format: "%.1f", brakeSensitivity))")
                //.foregroundColor(tabColor)
            Slider(value: $brakeSensitivity, in: 0...1)
                .tint(tabColor)

            Button("Calibrate Brakes") {
                // Perform a calibration test
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(.white)
            .tint(tabColor)

            Spacer()
        }
        .padding()
        .background(tabColor.opacity(0.15).cornerRadius(12))
        .shadow(radius: 5)
    }
}




#Preview {
    PerformanceTuningView()
}



