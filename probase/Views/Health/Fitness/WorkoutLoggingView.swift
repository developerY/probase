//
//  WorkoutLoggingView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/5/25.
//
import SwiftUI

struct WorkoutLoggingView: View {
    // Define available workout types.
    let workoutTypes = ["Running", "Cycling", "HIIT", "Strength", "Yoga"]
    
    // MARK: - State Properties for the form inputs.
    @State private var selectedWorkoutType = "Running"
    @State private var workoutDate = Date()
    @State private var duration: String = ""    // Duration in minutes.
    @State private var calories: String = ""    // Calories burned.
    @State private var notes: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient: from a soft green to a light blue.
                LinearGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.2), Color.blue.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Screen Title
                        Text("Log Workout")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        // Workout Details Section
                        VStack(spacing: 16) {
                            // Workout Type Picker
                            HStack {
                                Text("Workout Type:")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                Picker("Workout Type", selection: $selectedWorkoutType) {
                                    ForEach(workoutTypes, id: \.self) { type in
                                        Text(type).tag(type)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                            }
                            
                            // Date & Time Picker (Compact style)
                            HStack {
                                Text("Date & Time:")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                DatePicker("", selection: $workoutDate, displayedComponents: [.date, .hourAndMinute])
                                    .labelsHidden()
                                    .datePickerStyle(CompactDatePickerStyle())
                            }
                            
                            // Duration Input Field
                            HStack {
                                Text("Duration (min):")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                TextField("Enter duration", text: $duration)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 100)
                            }
                            
                            // Calories Input Field
                            HStack {
                                Text("Calories (kcal):")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                TextField("Enter calories", text: $calories)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 100)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // Notes Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Notes:")
                                .font(.headline)
                                .foregroundColor(.primary)
                            TextEditor(text: $notes)
                                .frame(height: 100)
                                .padding(4)
                                .background(Color(.systemBackground).opacity(0.9))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        
                        // Save Workout Button
                        Button(action: {
                            // Implement your save logic here.
                            print("Workout logged:")
                            print("Type: \(selectedWorkoutType)")
                            print("Date: \(workoutDate)")
                            print("Duration: \(duration)")
                            print("Calories: \(calories)")
                            print("Notes: \(notes)")
                        }) {
                            Text("Save Workout")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Log Workout")
        }
    }
}

// MARK: - Preview Provider

struct WorkoutLoggingView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLoggingView()
            .environment(\.colorScheme, .light)
    }
}

