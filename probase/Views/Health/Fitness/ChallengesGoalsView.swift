//
//  ChallengesGoalsView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/5/25.
//
import SwiftUI

struct ChallengesGoalsView: View {
    // MARK: - Data Models
    
    struct Challenge: Identifiable {
        let id = UUID()
        let title: String
        let progress: Double // Value between 0 and 1 representing completion percentage.
    }
    
    // Dummy Data
    let currentChallenge = Challenge(title: "7-Day Step Challenge", progress: 0.7)
    let availableChallenges: [Challenge] = [
        Challenge(title: "Daily 10K Steps", progress: 0.2),
        Challenge(title: "30-Day Workout", progress: 0.5),
        Challenge(title: "Improve Active Minutes", progress: 0.8)
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Edge-to-edge gradient background: Soft orange to light red.
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.3), Color.red.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Screen Title
                        Text("Challenges & Goals")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        // Current Challenge Card
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Current Challenge")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(currentChallenge.title)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            
                            // Progress Bar
                            ProgressView(value: currentChallenge.progress)
                                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                                .padding(.vertical, 4)
                            
                            Text("\(Int(currentChallenge.progress * 100))% Completed")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 4)
                        .padding(.horizontal)
                        
                        // Available Challenges List
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Available Challenges")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(availableChallenges) { challenge in
                                Button(action: {
                                    // Implement challenge join action.
                                }) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(challenge.title)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            
                                            ProgressView(value: challenge.progress)
                                                .progressViewStyle(LinearProgressViewStyle(tint: .green))
                                            
                                            Text("\(Int(challenge.progress * 100))% Completed")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .background(Color(.systemBackground))
                                    .cornerRadius(12)
                                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                                    .padding(.horizontal)
                                }
                            }
                        }
                        
                        // Custom Goal Section
                        Button(action: {
                            // Implement custom goal creation logic.
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                Text("Set Custom Goal")
                                    .font(.headline)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Challenges & Goals")
        }
    }
}

// MARK: - Preview Provider

struct ChallengesGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesGoalsView()
            .environment(\.colorScheme, .light)
    }
}

