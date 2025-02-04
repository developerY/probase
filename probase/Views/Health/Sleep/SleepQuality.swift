//
//  SleepQuality.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/4/25.
//
import SwiftUI

// Define an enum for Sleep Quality options.
enum SleepQuality: String, CaseIterable, Identifiable {
    case poor = "Poor"
    case average = "Average"
    case good = "Good"
    
    var id: String { self.rawValue }
}

struct SleepLoggingView: View {
    // MARK: - State Properties
    @State private var bedtime: Date = Date()  // Default to current time; customize as needed.
    @State private var wakeTime: Date = Date()
    @State private var sleepQuality: SleepQuality = .average
    @State private var notes: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Edge-to-edge gradient background: Semi-transparent Purple to Blue.
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.5), Color.blue.opacity(0.5)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Screen Title
                        Text("Log Sleep")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        // Bedtime & Wake Time Pickers using a compact style
                        VStack(spacing: 16) {
                            HStack {
                                Text("Bedtime:")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                DatePicker("", selection: $bedtime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .datePickerStyle(CompactDatePickerStyle())
                            }
                            
                            HStack {
                                Text("Wake Time:")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                DatePicker("", selection: $wakeTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .datePickerStyle(CompactDatePickerStyle())
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // Sleep Quality Rating
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Sleep Quality:")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Picker("Sleep Quality", selection: $sleepQuality) {
                                ForEach(SleepQuality.allCases) { quality in
                                    Text(quality.rawValue).tag(quality)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // Notes / Comments Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Notes:")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            TextEditor(text: $notes)
                                .frame(height: 100)
                                .padding(4)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        
                        // Save Sleep Log Button
                        Button(action: {
                            // Implement your save action here.
                            print("Sleep log saved:")
                            print("Bedtime: \(bedtime)")
                            print("Wake Time: \(wakeTime)")
                            print("Quality: \(sleepQuality.rawValue)")
                            print("Notes: \(notes)")
                        }) {
                            Text("Save Sleep Log")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Log Sleep")
        }
    }
}

// MARK: - Preview

struct SleepLoggingView_Previews: PreviewProvider {
    static var previews: some View {
        SleepLoggingView()
            .environment(\.colorScheme, .dark)
    }
}
