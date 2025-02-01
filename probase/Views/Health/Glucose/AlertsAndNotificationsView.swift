//
//  Untitled.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI

struct AlertsAndNotificationsView: View {
    @State private var lowBGAlert = true
    @State private var highBGAlert = true
    @State private var predictedLowAlert = false
    @State private var predictedHighAlert = false
    @State private var siteChangeReminder = false
    @State private var doNotDisturb = false

    var body: some View {
        Form {
            Section(header: Text("BG Threshold Alerts")) {
                Toggle("Low BG Alert", isOn: $lowBGAlert)
                Toggle("High BG Alert", isOn: $highBGAlert)
                Toggle("Predicted Low Alert", isOn: $predictedLowAlert)
                Toggle("Predicted High Alert", isOn: $predictedHighAlert)
            }

            Section(header: Text("Reminders")) {
                Toggle("Site Change Reminder", isOn: $siteChangeReminder)
                Toggle("Do Not Disturb (Nighttime)", isOn: $doNotDisturb)
            }
        }
        .navigationTitle("Alerts & Notifications")
    }
}
