//
//  HeartLogEventView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/3/25.
//
import SwiftUI

struct HeartLogEventView: View {
    // MARK: - State Properties
    @State private var eventDate: Date = Date()
    @State private var currentHR: String = ""
    @State private var chestPain: Bool = false
    @State private var dizziness: Bool = false
    @State private var palpitations: Bool = false
    @State private var shortnessOfBreath: Bool = false
    @State private var notes: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Radial gradient background to mix things up
                RadialGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.3), Color.blue.opacity(0.3)]),
                    center: .center,
                    startRadius: 100,
                    endRadius: 500
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Title
                        Text("Log Event")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        // Date/Time Display (could be made interactive if needed)
                        HStack {
                            Text("Date/Time:")
                                .font(.headline)
                            Spacer()
                            // Displaying the current event time
                            Text(eventDate, style: .time)
                                .font(.subheadline)
                            Image(systemName: "chevron.down")
                                .font(.subheadline)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                        // Current Heart Rate Input
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Current HR (BPM):")
                                .font(.headline)
                            TextField("Enter heart rate", text: $currentHR)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        // Symptoms Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Symptoms:")
                                .font(.headline)
                            Toggle("Chest Pain", isOn: $chestPain)
                            Toggle("Dizziness", isOn: $dizziness)
                            Toggle("Palpitations", isOn: $palpitations)
                            Toggle("Shortness of Breath", isOn: $shortnessOfBreath)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        
                        // Additional Notes
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Additional Notes:")
                                .font(.headline)
                            TextEditor(text: $notes)
                                .frame(height: 100)
                                .padding(4)
                                .background(Color(.systemBackground))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        // Save Event Button
                        Button(action: {
                            // Implement the event saving logic here.
                        }) {
                            Text("Save Event")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                } // ScrollView
            } // ZStack
            .navigationTitle("Log Event")
        } // NavigationView
    }
}

struct HeartLogEventView_Previews: PreviewProvider {
    static var previews: some View {
        HeartLogEventView()
    }
}

