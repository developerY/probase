//
//  BadgesView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI

struct BadgesView: View {
    let badges: [BadgeItem]

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [.purple.opacity(0.8), .blue.opacity(0.7)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    Text("My Badges")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 16) {
                        ForEach(badges) { badge in
                            VStack(spacing: 8) {
                                Image(systemName: badge.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(badge.isEarned ? .green : .black)

                                Text(badge.name)
                                    .font(.headline)
                                    .foregroundColor(badge.isEarned ? .white : .black)

                                Text(badge.isEarned ? "Earned" : "Locked")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .frame(width: 120, height: 150)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.2))
                            )
                            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 3)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Badges")
    }
}


let mockBadges = [
    BadgeItem(name: "Eco-Warrior", description: "Awarded for saving 10kg of CO₂", iconName: "leaf.fill", isEarned: true),
    BadgeItem(name: "Bike Commuter", description: "Commute by bike 5 days in a row", iconName: "bicycle", isEarned: true),
    BadgeItem(name: "100 Miles", description: "Ride 100 miles this month", iconName: "road.lanes", isEarned: false)
]


struct BadgeItem : Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let iconName: String
    let isEarned: Bool
}



