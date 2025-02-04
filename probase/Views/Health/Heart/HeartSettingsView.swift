//
//  HeartSettingsView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/3/25.
//
import SwiftUI

struct HeartSettingsView: View {
    // MARK: - State Properties
    @State private var profileName: String = "Jane Doe"
    @State private var email: String = "jane.doe@example.com"
    
    // Target heart rate zones
    @State private var targetLow: String = "50"
    @State private var targetHigh: String = "100"
    
    // Integration toggles
    @State private var isAppleHealthEnabled: Bool = true
    @State private var isGoogleFitEnabled: Bool = false
    
    // Data backup and security toggles
    @State private var isCloudBackupEnabled: Bool = true
    @State private var isFaceIDEnabled: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                // Edge-to-edge gradient background (Green to Blue)
                LinearGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.3), Color.blue.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // MARK: - Profile Information Section
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.blue)
                                    .padding()
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(profileName)
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
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                        
                        // MARK: - Heart Rate Zones Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Heart Rate Zones")
                                .font(.headline)
                            HStack(spacing: 16) {
                                VStack(alignment: .leading) {
                                    Text("Low (BPM)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    TextField("50", text: $targetLow)
                                        .keyboardType(.numberPad)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 80)
                                }
                                VStack(alignment: .leading) {
                                    Text("High (BPM)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    TextField("100", text: $targetHigh)
                                        .keyboardType(.numberPad)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 80)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                        
                        // MARK: - Integrations Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Integrations")
                                .font(.headline)
                            Toggle(isOn: $isAppleHealthEnabled) {
                                HStack {
                                    Image(systemName: "heart.circle")
                                        .foregroundColor(.red)
                                    Text("Apple Health")
                                }
                            }
                            Toggle(isOn: $isGoogleFitEnabled) {
                                HStack {
                                    Image(systemName: "g.circle")
                                        .foregroundColor(.green)
                                    Text("Google Fit")
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                        
                        // MARK: - Data Backup Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Data Backup")
                                .font(.headline)
                            Toggle(isOn: $isCloudBackupEnabled) {
                                Text("iCloud Backup")
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                        
                        // MARK: - Security Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Security")
                                .font(.headline)
                            Toggle(isOn: $isFaceIDEnabled) {
                                Text("Face ID / PIN Lock")
                            }
                            Button(action: {
                                // Implement export/import data functionality here.
                            }) {
                                HStack {
                                    Image(systemName: "arrow.up.arrow.down.circle")
                                    Text("Export/Import Data")
                                }
                                .font(.subheadline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(12)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Settings & Profile")
        }
    }
}

struct HeartSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        HeartSettingsView()
    }
}

