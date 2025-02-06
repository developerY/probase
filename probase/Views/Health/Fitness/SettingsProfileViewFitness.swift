//
//  SettingsProfileView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/5/25.
//
import SwiftUI

struct SettingsProfileViewFitness: View {
    // MARK: - State Properties
    @State private var userName: String = "John Doe"
    @State private var email: String = "john.doe@example.com"
    
    // Personal Goals
    @State private var dailyStepsGoal: String = "10000"
    @State private var dailyCaloriesGoal: String = "2000"
    @State private var dailyActiveMinutes: String = "60"
    
    // Integrations
    @State private var isAppleHealthEnabled: Bool = true
    @State private var isFitbitEnabled: Bool = false
    
    // Privacy
    @State private var isPrivacyEnabled: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient: from purple to blue.
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple.opacity(0.3), Color.blue.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Profile Section
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.blue)
                                .padding()
                            VStack(alignment: .leading, spacing: 4) {
                                Text(userName)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text(email)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Button(action: {
                                // Implement profile edit action here.
                            }) {
                                Text("Edit")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                            .padding()
                        }
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // Personal Goals Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Personal Goals")
                                .font(.headline)
                            HStack {
                                Text("Daily Steps:")
                                Spacer()
                                TextField("Steps", text: $dailyStepsGoal)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 100)
                            }
                            HStack {
                                Text("Calories:")
                                Spacer()
                                TextField("Calories", text: $dailyCaloriesGoal)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 100)
                            }
                            HStack {
                                Text("Active Minutes:")
                                Spacer()
                                TextField("Minutes", text: $dailyActiveMinutes)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 100)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // Integrations Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Integrations")
                                .font(.headline)
                            Toggle(isOn: $isAppleHealthEnabled) {
                                HStack {
                                    Image(systemName: "heart.circle")
                                        .foregroundColor(.red)
                                    Text("Apple Health")
                                }
                            }
                            Toggle(isOn: $isFitbitEnabled) {
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
                        
                        // Privacy Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Privacy & Security")
                                .font(.headline)
                            Toggle(isOn: $isPrivacyEnabled) {
                                Text("Enable PIN/Face ID")
                                    .font(.subheadline)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // Save Settings Button
                        Button(action: {
                            // Implement save settings action here.
                        }) {
                            Text("Save Settings")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Settings & Profile")
        }
    }
}

// MARK: - Preview Provider

struct SettingsProfileViewFitness_Previews: PreviewProvider {
    static var previews: some View {
        SettingsProfileViewFitness()
            .environment(\.colorScheme, .light)
    }
}

