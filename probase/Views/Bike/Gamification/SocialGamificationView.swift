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

    @StateObject private var viewModel = NFTLibraryViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.8), .green.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        Text("Social & Gamification")
                            .font(.largeTitle.weight(.bold))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                            .shadow(radius: 5)

                        // MARK: - Weekly Miles Card
                        cardView {
                            VStack(spacing: 8) {
                                Text("Weekly Miles: \(weeklyMiles)")
                                    .font(.title.weight(.semibold))
                                    .foregroundColor(.white)
                                    .shadow(radius: 3)

                                Text("CO₂ Saved: \(String(format: "%.1f", co2Saved)) kg")
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                            }
                        }/*.background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.skyBlue.opacity(0.3), .aqua.opacity(0.3)]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                        )*/
                        /*.cardBackgroundGradient(
                            with: LinearGradient(
                                gradient: Gradient(colors: [.skyBlue.opacity(0.3), .aqua.opacity(0.3)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )*/


                        // MARK: - Current Badge Card
                        cardView {
                            HStack(spacing: 12) {
                                Image(systemName: "leaf.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                                    .shadow(radius: 2)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Current Badge")
                                        .font(.caption)
                                        .foregroundColor(.secondary)

                                    Text(currentBadge)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                                Spacer()

                                NavigationLink("View All Badges") {
                                    BadgesView(badges: mockBadges)
                                }
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            }
                        }

                        // MARK: - Leaderboard Card
                        cardView {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Text("Leaderboard")
                                        .font(.title3.weight(.semibold))
                                        .foregroundColor(.white)
                                        .shadow(radius: 2)

                                    Spacer()

                                    NavigationLink("See All") {
                                        Text("Full Leaderboard Screen")
                                    }
                                    .font(.callout)
                                    .foregroundColor(.blue)
                                }

                                ForEach(mockLeaders) { user in
                                    HStack {
                                        Text("\(user.rank). \(user.name)")
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text("\(user.miles) mi")
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }

                        // MARK: - Challenges Card
                        cardView {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Active Challenges")
                                    .font(.title3.weight(.semibold))
                                    .foregroundColor(.white)
                                    .shadow(radius: 2)

                                ForEach(mockChallenges) { challenge in
                                    HStack {
                                        Text(challenge.title)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text("\(challenge.progress)%")
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }.cardBackground(with: .blue.opacity(0.3))

                        // MARK: - NFT Prizes Card
                        cardView {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Image(systemName: "hexagon.fill")
                                        .font(.title3)
                                        .foregroundColor(.purple)

                                    Text("My NFT Prizes")
                                        .font(.title3.weight(.semibold))
                                        .foregroundColor(.white)
                                }

                                if viewModel.nftItems.isEmpty {
                                    Text("No NFTs yet. Complete challenges to earn them!")
                                        .foregroundColor(.secondary)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 12) {
                                            ForEach(viewModel.nftItems) { nft in
                                                NFTCardView(nft: nft)
                                                    .frame(width: 120)
                                                    .onTapGesture {
                                                        viewModel.selectedNFT = nft
                                                        viewModel.showDetail = true
                                                    }
                                            }
                                        }
                                    }
                                }

                                NavigationLink("View All NFTs") {
                                    NFTLibraryView()
                                }
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            }
                        }

                        Spacer(minLength: 30)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Social Gamification")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Card View Builder
    private func cardView<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .padding()
            .frame(maxWidth: .infinity)
            .background(.thinMaterial)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
    }
}

extension View {
    func cardBackgroundGradient(with gradient: LinearGradient) -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(gradient)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
    }
}

extension View {
    func cardBackground(with color: Color) -> some View {
        self.background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.thinMaterial)
                .overlay(RoundedRectangle(cornerRadius: 16).fill(color))
                .shadow(color: color.opacity(0.3), radius: 5, x: 0, y: 3)
        )
    }
}

extension View {
    func frostedGlassCard() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.15))  // A light, transparent base
                    .blur(radius: 10)                 // Create blur to simulate frosted look
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)  // Subtle white border for definition
            )
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 5)  // Light shadow for depth
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}



extension Color {
    static let skyBlue = Color(red: 0.53, green: 0.81, blue: 0.92)  // Example RGB values
    static let mintGreen = Color(red: 0.6, green: 0.98, blue: 0.6)
    static let pastelOrange = Color(red: 1.0, green: 0.87, blue: 0.68)
    static let lavender = Color(red: 0.9, green: 0.9, blue: 1.0)
    static let peach = Color(red: 1.0, green: 0.85, blue: 0.72)
    static let aqua = Color(red: 0.5, green: 0.85, blue: 0.9)         // Aqua-inspired color
    
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

#Preview {
    SocialGamificationView()
}
