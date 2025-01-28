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
            VStack {
                // Tab Picker
                Picker("Performance Tabs", selection: $selectedTab) {
                    ForEach(TuningTab.allCases, id: \.self) { tab in
                        Text(tab.title).tag(tab)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Tab Content
                switch selectedTab {
                case .suspension:
                    SuspensionTuningCard()
                case .gearing:
                    GearingTuningCard()
                case .brakes:
                    BrakeMonitoringCard()
                }
                
                Spacer()
            }
            .navigationTitle("Performance Tuning")
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
}

// MARK: - Suspension
struct SuspensionTuningCard: View {
    @State private var riderWeight: Double = 70
    @State private var currentMode: String = "Comfort"
    
    let modes = ["Comfort", "Sport", "Off-Road"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Suspension Setup")
                .font(.headline)
            
            HStack {
                Text("Rider Weight: \(Int(riderWeight)) kg")
                Slider(value: $riderWeight, in: 50...120, step: 1)
                    .tint(.blue)
            }
            
            Picker("Mode", selection: $currentMode) {
                ForEach(modes, id: \.self) { mode in
                    Text(mode).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            
            Button("Apply Settings") {
                // Send to suspension system
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Gearing
struct GearingTuningCard: View {
    @State private var autoShiftEnabled = true
    @State private var targetCadence: Double = 85
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Gearing Optimization")
                .font(.headline)
            
            Toggle("Enable Auto-Shifting", isOn: $autoShiftEnabled)
            
            HStack {
                Text("Target Cadence: \(Int(targetCadence)) rpm")
                Slider(value: $targetCadence, in: 60...120, step: 5)
                    .tint(.green)
            }
            
            Button("Apply Gear Settings") {
                // Send to electronic drivetrain
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Brakes
struct BrakeMonitoringCard: View {
    @State private var brakeSensitivity: Double = 0.5
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Brake Monitoring")
                .font(.headline)
            
            Text("Current Sensitivity: \(String(format: "%.1f", brakeSensitivity))")
            Slider(value: $brakeSensitivity, in: 0...1)
                .tint(.red)
            
            Button("Calibrate Brakes") {
                // Perform a calibration test
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            
            Spacer()
        }
        .padding()
    }
}

#Preview{
    PerformanceTuningView()
}


