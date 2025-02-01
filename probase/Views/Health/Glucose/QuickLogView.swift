//
//  QuickLogView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI

struct QuickLogView: View {
    @State private var glucoseValue: String = ""
    @State private var date = Date()
    @State private var notes: String = ""
    @State private var showInsulinOptions = false
    @State private var insulinDose: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Glucose Reading")) {
                    TextField("BG (e.g. 5.8)", text: $glucoseValue)
                        .keyboardType(.decimalPad)
                    
                    DatePicker("Timestamp", selection: $date, displayedComponents: .hourAndMinute)
                    TextField("Notes or tags", text: $notes)
                }

                if showInsulinOptions {
                    Section(header: Text("Insulin")) {
                        TextField("Bolus dose (units)", text: $insulinDose)
                            .keyboardType(.decimalPad)
                    }
                }

                Button(showInsulinOptions ? "Hide Insulin Options" : "Show Insulin Options") {
                    withAnimation {
                        showInsulinOptions.toggle()
                    }
                }

                Button("Save Entry") {
                    // Save logic (glucoseData.append(...), etc.)
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Quick Log")
        }
    }
}

