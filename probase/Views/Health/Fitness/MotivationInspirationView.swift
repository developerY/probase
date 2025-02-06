//
//  MotivationInspirationView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/5/25.
//
import SwiftUI

struct MotivationInspirationView: View {
    // Dummy data for the screen
    let dailyQuote: String = "\"Your body can stand almost anything. It's your mind that you have to convince.\""
    let author: String = "– Unknown"
    let dailyTip: String = "Push yourself, because no one else is going to do it for you."
    let achievements: [String] = ["10K Steps", "Marathon", "Workout Streak", "HIIT Champion"]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Edge-to-edge gradient background: Pink to Yellow
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.3), Color.yellow.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Screen Title
                        Text("Motivation & Inspiration")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding(.top)
                        
                        // Inspirational Quote Section
                        VStack(spacing: 8) {
                            Text(dailyQuote)
                                .font(.title2)
                                .italic()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.primary)
                            Text(author)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)
                        
                        // Tip of the Day Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Today's Tip")
                                .font(.headline)
                                .foregroundColor(.primary)
                            Text(dailyTip)
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.8))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // Achievements Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Achievements")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(achievements, id: \.self) { badge in
                                        VStack {
                                            Image(systemName: "star.fill")
                                                .font(.largeTitle)
                                                .foregroundColor(.yellow)
                                            Text(badge)
                                                .font(.caption)
                                                .foregroundColor(.primary)
                                        }
                                        .padding()
                                        .background(Color(.systemBackground))
                                        .cornerRadius(12)
                                        .shadow(radius: 2)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        // Call-to-Action Button for Daily Challenge
                        Button(action: {
                            // Implement join challenge action here.
                        }) {
                            HStack {
                                Image(systemName: "flame.fill")
                                    .font(.title2)
                                Text("Join Today's Challenge")
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
            .navigationTitle("Motivation")
        }
    }
}

struct MotivationInspirationView_Previews: PreviewProvider {
    static var previews: some View {
        MotivationInspirationView()
            .environment(\.colorScheme, .light)
    }
}

