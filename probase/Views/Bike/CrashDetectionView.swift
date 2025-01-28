//
//  BikeNext.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/27/25.
//
import SwiftUI
import CoreMotion // For accelerometer, gyroscope, etc.

struct CrashDetectionView: View {
    // MARK: - State and Properties
    @State private var isCrashDetected = false
    @State private var emergencyContact = "John Doe"
    @State private var alertThreshold: Double = 2.5 // G-force threshold
    @State private var isMonitoringActive = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                LinearGradient(
                    gradient: Gradient(colors: [.red.opacity(0.8), .orange.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    
                    Text("Crash Detection")
                        .font(.largeTitle.weight(.heavy))
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    
                    // Current State
                    VStack(spacing: 10) {
                        Text(isMonitoringActive ? "Monitoring On" : "Monitoring Off")
                            .font(.title2)
                            .foregroundColor(.white)
                        Toggle("Crash Detection Active", isOn: $isMonitoringActive)
                            .toggleStyle(SwitchToggleStyle(tint: .white))
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Threshold Settings
                    VStack(alignment: .leading, spacing: 12) {
                        Text("G-Force Threshold: \(String(format: "%.1f", alertThreshold))g")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        
                        Slider(value: $alertThreshold, in: 1.0...5.0, step: 0.5)
                            .tint(.white)
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Emergency Contact
                    VStack(spacing: 16) {
                        Text("Emergency Contact")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text(emergencyContact)
                            .font(.title2.weight(.bold))
                            .foregroundColor(.white)
                        
                        NavigationLink("Change Contact") {
                            // A detail screen to select or edit contact
                            Text("Emergency Contact Selection Screen")
                        }
                        .font(.body)
                        .foregroundColor(.blue)
                        .padding(.top, 4)
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)
                    
                    // Crash Alert Status
                    if isCrashDetected {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.yellow)
                            Text("Crash Detected!")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                        .transition(.scale)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview{
        CrashDetectionView()
}

