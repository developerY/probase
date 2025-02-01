//
//  SettingsProfileView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI

struct SettingsProfileView: View {
    @State private var useMGDL = false
    @State private var lowThreshold: Double = 4.0
    @State private var highThreshold: Double = 10.0
    @State private var notificationsEnabled = true

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile")) {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text("John Doe")
                            .foregroundColor(.secondary)
                    }
                    // Could add more fields here...
                }

                Section(header: Text("Units & Targets")) {
                    Toggle("Use mg/dL instead of mmol/L", isOn: $useMGDL)
                    HStack {
                        Text("Low BG Alert")
                        Spacer()
                        TextField("", value: $lowThreshold, format: .number)
                            .keyboardType(.decimalPad)
                            .frame(width: 50)
                    }
                    HStack {
                        Text("High BG Alert")
                        Spacer()
                        TextField("", value: $highThreshold, format: .number)
                            .keyboardType(.decimalPad)
                            .frame(width: 50)
                    }
                }

                Section(header: Text("Notifications")) {
                    Toggle("Enable Alerts", isOn: $notificationsEnabled)
                    NavigationLink("Alert Settings") {
                        AlertsAndNotificationsView()
                    }
                }

                Section(header: Text("Other")) {
                    NavigationLink("Reports & Sharing") {
                        ReportsAndSharingView()
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

