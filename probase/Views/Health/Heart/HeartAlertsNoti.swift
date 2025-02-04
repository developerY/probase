//
//  HeartAlertsNoti.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/3/25.
//
import SwiftUI

enum NotificationStyle: String, CaseIterable {
    case banner
    case sound
    case vibrate
}

struct HeartAlertsView: View {
    // MARK: - State Properties
    @State private var highHRAlertEnabled: Bool = true
    @State private var highHRThreshold: String = "100"  // as BPM
    @State private var lowHRAlertEnabled: Bool = true
    @State private var lowHRThreshold: String = "50"      // as BPM
    @State private var irregularRhythmAlertEnabled: Bool = false
    @State private var notificationStyle: NotificationStyle = .banner
    @State private var doNotDisturbStart: Date = Date()
    @State private var doNotDisturbEnd: Date = Calendar.current.date(byAdding: .hour, value: 8, to: Date()) ?? Date()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Edge-to-edge gradient background: Purple to Teal
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.4), Color.teal.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // High Heart Rate Alert Toggle & Threshold
                        VStack(alignment: .leading, spacing: 8) {
                            Toggle(isOn: $highHRAlertEnabled) {
                                Text("High Heart Rate Alert")
                                    .font(.headline)
                            }
                            if highHRAlertEnabled {
                                HStack {
                                    Text("Threshold (BPM):")
                                    TextField("100", text: $highHRThreshold)
                                        .keyboardType(.numberPad)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 60)
                                }
                                .padding(.leading)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                        
                        // Low Heart Rate Alert Toggle & Threshold
                        VStack(alignment: .leading, spacing: 8) {
                            Toggle(isOn: $lowHRAlertEnabled) {
                                Text("Low Heart Rate Alert")
                                    .font(.headline)
                            }
                            if lowHRAlertEnabled {
                                HStack {
                                    Text("Threshold (BPM):")
                                    TextField("50", text: $lowHRThreshold)
                                        .keyboardType(.numberPad)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 60)
                                }
                                .padding(.leading)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                        
                        // Irregular Rhythm Alert Toggle
                        VStack(alignment: .leading, spacing: 8) {
                            Toggle(isOn: $irregularRhythmAlertEnabled) {
                                Text("Irregular Rhythm Alert")
                                    .font(.headline)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                        
                        // Notification Style Selector
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Notification Style")
                                .font(.headline)
                            Picker("Notification Style", selection: $notificationStyle) {
                                ForEach(NotificationStyle.allCases, id: \.self) { style in
                                    Text(style.rawValue.capitalized).tag(style)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                        
                        // Do Not Disturb Settings
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Do Not Disturb")
                                .font(.headline)
                            HStack {
                                DatePicker("From", selection: $doNotDisturbStart, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                Text("to")
                                DatePicker("To", selection: $doNotDisturbEnd, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                    }
                    .padding()
                }
            }
            .navigationTitle("Alerts & Notifications")
        }
    }
}

struct HeartAlertsView_Previews: PreviewProvider {
    static var previews: some View {
        HeartAlertsView()
    }
}

