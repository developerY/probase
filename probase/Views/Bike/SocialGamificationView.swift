//
//  SocialGamificationView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/27/25.
//
import SwiftUI

struct SocialGamificationView: View {
    @State private var weeklyMiles = 72
    @State private var co2Saved = 18.5 // in kg
    @State private var currentBadge = "Eco-Warrior"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Stats Header
                    VStack(spacing: 8) {
                        Text("Weekly Miles: \(weeklyMiles)")
                            .font(.title.weight(.bold))
                        
                        Text("CO₂ Saved: \(String(format: "%.1f", co2Saved)) kg")
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Current Badge
                    HStack {
                        Image(systemName: "leaf.fill")
                            .font(.largeTitle)
                            .foregroundColor(.green)
                        VStack(alignment: .leading) {
                            Text("Current Badge")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(currentBadge)
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        Spacer()
                        
                        Button("View All Badges") {
                            // Navigate to badges gallery
                        }
                        .font(.subheadline)
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Leaderboard
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Leaderboard")
                                .font(.title3.weight(.semibold))
                            Spacer()
                            NavigationLink("See All") {
                                Text("Full Leaderboard Screen")
                            }
                        }
                        
                        ForEach(mockLeaders) { user in
                            HStack {
                                Text("\(user.rank). \(user.name)")
                                Spacer()
                                Text("\(user.miles) mi")
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Challenges
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Active Challenges")
                            .font(.title3.weight(.semibold))
                        
                        ForEach(mockChallenges) { challenge in
                            HStack {
                                Text(challenge.title)
                                Spacer()
                                Text("\(challenge.progress)%")
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .navigationTitle("Social & Gamification")
        }
    }
}

// MARK: - Sample Models
struct LeaderboardUser: Identifiable {
    let id = UUID()
    let rank: Int
    let name: String
    let miles: Int
}

let mockLeaders = [
    LeaderboardUser(rank: 1, name: "Alice", miles: 120),
    LeaderboardUser(rank: 2, name: "Bob", miles: 90),
    LeaderboardUser(rank: 3, name: "Carol", miles: 85),
]

struct Challenge: Identifiable {
    let id = UUID()
    let title: String
    let progress: Int
}

let mockChallenges = [
    Challenge(title: "Ride 100 Miles This Month", progress: 45),
    Challenge(title: "Commute by Bike 5 Days in a Row", progress: 60)
]

#Preview
{
    SocialGamificationView()
}

