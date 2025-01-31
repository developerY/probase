//
//  BikeNext.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/27/25.
//
import SwiftUI
import CoreMotion

struct CrashDetectionView: View {
    // MARK: - State and Properties
    @State private var isCrashDetected = false
    @State private var emergencyContact = "John Doe"
    @State private var alertThreshold: Double = 2.5
    @State private var isMonitoringActive = false

    // Dynamic background based on monitoring state
    private var dynamicBackground: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: isMonitoringActive ? [.green.opacity(0.8), .blue.opacity(0.8)] : [.red.opacity(0.8), .orange.opacity(0.8)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Dynamic background
                dynamicBackground.ignoresSafeArea()

                VStack(spacing: 30) {
                    // Title
                    Text("Crash Detection")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    // Current State Section
                    VStack(spacing: 16) {
                        HStack {
                            Label(isMonitoringActive ? "Monitoring On" : "Monitoring Off", systemImage: isMonitoringActive ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(.white)
                        }
                        .animation(.easeInOut, value: isMonitoringActive)

                        Toggle("Crash Detection Active", isOn: $isMonitoringActive)
                            .toggleStyle(SwitchToggleStyle(tint: .white))
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)

                    // G-Force Threshold Settings
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

                    // Emergency Contact Section
                    VStack(spacing: 16) {
                        HStack {
                            Label("Emergency Contact", systemImage: "person.crop.circle.fill")
                                .font(.headline)
                                .foregroundColor(.white)
                        }

                        Text(emergencyContact)
                            .font(.title2.weight(.bold))
                            .foregroundColor(.white)

                        NavigationLink(destination: Text("Emergency Contact Selection Screen")) {
                            Label("Change Contact", systemImage: "pencil")
                                .font(.body)
                                .foregroundColor(.blue)
                        }
                        .padding(.top, 4)
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)

                    // Animated Crash Alert
                    if isCrashDetected {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.yellow)
                                .scaleEffect(isCrashDetected ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: isCrashDetected)

                            Text("Crash Detected!")
                                .font(.title)
                                .foregroundColor(.white)
                                .scaleEffect(isCrashDetected ? 1.05 : 1.0)
                        }
                        .padding()
                        .background(Color.red)
                        .cornerRadius(12)
                        .shadow(radius: 10)
                        .transition(.scale)
                    }

                    Spacer()
                }
                .padding(.horizontal)
                .onAppear {
                    // Simulate a crash alert after 5 seconds (for demo purposes)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        withAnimation {
                            isCrashDetected.toggle()
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview
#Preview {
    CrashDetectionView()
}
