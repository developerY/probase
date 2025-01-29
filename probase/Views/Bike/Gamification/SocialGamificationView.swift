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
    
    // Example pastel tints
    private let pastelBlue   = Color(red: 0.85, green: 0.93, blue: 1.0)
    private let pastelGreen  = Color(red: 0.85, green: 1.0,  blue: 0.93)
    private let pastelOrange = Color(red: 1.0,  green: 0.9,  blue: 0.8)
    private let pastelYellow = Color(red: 1.0,  green: 0.97, blue: 0.85)
    
    let viewModel = NFTLibraryViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.8),
                        Color.green.opacity(0.8)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                        Text("Social & Gamification")
                            .font(.largeTitle.weight(.bold))
                            .foregroundColor(.primary)
                            .padding(.top, 20)
                        
                        // MARK: - Weekly Miles Card
                        VStack(spacing: 8) {
                            Text("Weekly Miles: \(weeklyMiles)")
                                .font(.title.weight(.semibold))
                                .foregroundColor(.primary)
                            
                            Text("CO₂ Saved: \(String(format: "%.1f", co2Saved)) kg")
                                .font(.subheadline)
                                .foregroundColor(.green)
                        }
                        .padding(.vertical, 30)
                        .frame(maxWidth: .infinity)
                        .frostedTintBackground(color: pastelBlue.opacity(0.3))
                        .padding(.horizontal)
                        
                        // MARK: - Current Badge Card
                        HStack(spacing: 12) {
                            Image(systemName: "leaf.fill")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Current Badge")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Text(currentBadge)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            Spacer()
                            
                            Button("View All Badges") {
                                // Navigate to badges gallery
                            }
                            .foregroundColor(.blue)
                            .font(.subheadline)
                        }
                        .padding()
                        .frostedTintBackground(color: pastelGreen.opacity(0.3))
                        .padding(.horizontal)
                        
                        // MARK: - Leaderboard Card
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Leaderboard")
                                    .font(.title3.weight(.semibold))
                                    .foregroundColor(.primary)
                                Spacer()
                                NavigationLink("See All") {
                                    Text("Full Leaderboard Screen")
                                }
                                .font(.callout)
                            }
                            
                            ForEach(mockLeaders) { user in
                                HStack {
                                    Text("\(user.rank). \(user.name)")
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Text("\(user.miles) mi")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding()
                        .frostedTintBackground(color: pastelOrange.opacity(0.3))
                        .padding(.horizontal)
                        
                        // MARK: - Challenges Card
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Active Challenges")
                                .font(.title3.weight(.semibold))
                                .foregroundColor(.primary)
                            
                            ForEach(mockChallenges) { challenge in
                                HStack {
                                    Text(challenge.title)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Text("\(challenge.progress)%")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding()
                        .frostedTintBackground(color: pastelYellow.opacity(0.3))
                        .padding(.horizontal)
                        
                        // Under your "Active Challenges" card:
                        VStack(alignment: .leading, spacing: 12) {
                            
                            HStack {
                                   // Example NFT icon
                                   Image(systemName: "hexagon.fill")
                                       .font(.title3)
                                       .foregroundColor(.purple)
                                   
                                   Text("My NFT Prizes")
                                       .font(.title3.weight(.semibold))
                                       .foregroundColor(.primary)
                               }
                            
                            if viewModel.nftItems.isEmpty {
                                Text("No NFTs yet. Complete challenges to earn them!")
                                    .foregroundColor(.secondary)
                            } else {
                                // Quick row or mini-grid
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(viewModel.nftItems) { nft in
                                            NFTCardView(nft: nft)
                                                //.frame(width: 120) // mini display
                                                .onTapGesture {
                                                    viewModel.selectedNFT = nft
                                                    viewModel.showDetail = true
                                                }
                                        }
                                    }
                                }
                            }
                            
                            Button("View All NFTs") {
                                // Navigate to NFTLibraryView
                            }
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        }
                        .padding()
                        .frostedTintBackground(color: pastelBlue.opacity(0.3))
                        .padding(.horizontal)
                        //.background(... styled background ...)
                        //.shadow(...)
                        
                        Spacer(minLength: 30)

                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Frosted Glass Modifier
extension View {
    /// Applies a frosted glass background plus a color overlay
    func frostedTintBackground(color: Color) -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.thinMaterial) // The frosted/blurry material
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .fill(color) // Semi-transparent tint
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
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

#Preview{
        SocialGamificationView()
}
