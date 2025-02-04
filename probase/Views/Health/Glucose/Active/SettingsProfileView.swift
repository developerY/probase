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
        
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.4), .indigo.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
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
                }.scrollContentBackground(.hidden)  // Removes the default form background
                .background(Color.white.opacity(0.1))
                .cornerRadius(16)
            }.navigationTitle("Settings")
        }
    }
}

// MARK: - Preview
struct SettingsProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsProfileView()
            .preferredColorScheme(.light)
    }
}
