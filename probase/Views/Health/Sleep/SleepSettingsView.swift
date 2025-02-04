//
//  SleepSettingsView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/4/25.
//
import SwiftUI

struct SleepSettingsView: View {
    // MARK: - State Properties
    @State private var targetSleepDuration: Double = 8.0  // in hours
    @State private var isBedtimeReminderOn: Bool = true
    @State private var reminderTime: Date = Calendar.current.date(from: DateComponents(hour: 22, minute: 0)) ?? Date()
    @State private var isAppleHealthEnabled: Bool = true
    @State private var isFitbitSyncEnabled: Bool = false
    @State private var isPrivacyLockEnabled: Bool = true  // e.g., PIN Lock / Face ID
    
    var body: some View {
        NavigationView {
            ZStack {
                // Edge-to-edge gradient background: Teal to Blue
                LinearGradient(
                    gradient: Gradient(colors: [Color.teal.opacity(0.3), Color.blue.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Screen Title
                        Text("Sleep Settings")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        // MARK: - Target Sleep Duration Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Target Sleep Duration:")
                                .font(.headline)
                            HStack {
                                Slider(value: $targetSleepDuration, in: 4...12, step: 0.5)
                                Text("\(targetSleepDuration, specifier: "%.1f") hrs")
                                    .frame(width: 60, alignment: .trailing)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // MARK: - Bedtime Reminder Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Bedtime Reminder:")
                                .font(.headline)
                            Toggle(isOn: $isBedtimeReminderOn) {
                                Text("Enable Reminder")
                                    .font(.subheadline)
                            }
                            if isBedtimeReminderOn {
                                HStack {
                                    Text("Reminder Time:")
                                        .font(.subheadline)
                                    Spacer()
                                    DatePicker("", selection: $reminderTime, displayedComponents: .hourAndMinute)
                                        .labelsHidden()
                                        .datePickerStyle(CompactDatePickerStyle())
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // MARK: - Integrations Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Integrations:")
                                .font(.headline)
                            Toggle(isOn: $isAppleHealthEnabled) {
                                HStack {
                                    Image(systemName: "heart.circle")
                                        .foregroundColor(.red)
                                    Text("Apple Health")
                                }
                            }
                            Toggle(isOn: $isFitbitSyncEnabled) {
                                HStack {
                                    Image(systemName: "figure.walk")
                                        .foregroundColor(.green)
                                    Text("Fitbit Sync")
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // MARK: - Privacy Settings Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Privacy Settings:")
                                .font(.headline)
                            Toggle(isOn: $isPrivacyLockEnabled) {
                                Text("Enable PIN Lock / Face ID")
                                    .font(.subheadline)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.vertical)
                } // ScrollView
            } // ZStack
            .navigationTitle("Sleep Settings")
        } // NavigationView
    }
}

// MARK: - Preview

struct SleepSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SleepSettingsView()
            .environment(\.colorScheme, .light)
    }
}

