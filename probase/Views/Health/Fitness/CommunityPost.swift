//
//  CommunityPost.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/6/25.
//
import SwiftUI

// MARK: - Data Model for Community Post

struct CommunityPost: Identifiable {
    let id = UUID()
    let username: String
    let avatar: String  // SF Symbol name, e.g., "person.circle.fill"
    let message: String
    let timestamp: Date
}

// MARK: - Community Feed Screen

struct CommunityFeedView: View {
    // Dummy data for posts
    let posts: [CommunityPost] = [
        CommunityPost(username: "Alice", avatar: "person.circle.fill", message: "Just finished a 5K run! Feeling amazing!", timestamp: Date().addingTimeInterval(-3600)),
        CommunityPost(username: "Bob", avatar: "person.circle.fill", message: "Crushed my HIIT session today – no excuses!", timestamp: Date().addingTimeInterval(-7200)),
        CommunityPost(username: "Charlie", avatar: "person.circle.fill", message: "I set a new personal record on the treadmill!", timestamp: Date().addingTimeInterval(-10800)),
        CommunityPost(username: "Dana", avatar: "person.circle.fill", message: "Completed a yoga session and feeling so relaxed.", timestamp: Date().addingTimeInterval(-14400))
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient: from soft orange to light red.
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.3), Color.red.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(posts) { post in
                            CommunityPostView(post: post)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Community Feed")
        }
    }
}

// MARK: - View for Individual Community Post

struct CommunityPostView: View {
    let post: CommunityPost
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header with avatar, username, and timestamp.
            HStack(spacing: 12) {
                Image(systemName: post.avatar)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                VStack(alignment: .leading) {
                    Text(post.username)
                        .font(.headline)
                    Text(post.timestamp, style: .time)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            
            // Post Message
            Text(post.message)
                .font(.body)
                .foregroundColor(.primary)
            
            // Action Buttons (Like and Comment)
            HStack {
                Button(action: {
                    // Implement like action here.
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "heart")
                        Text("Like")
                            .font(.subheadline)
                    }
                }
                Spacer()
                Button(action: {
                    // Implement comment action here.
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "bubble.left")
                        Text("Comment")
                            .font(.subheadline)
                    }
                }
            }
            .padding(.top, 4)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Preview Provider

struct CommunityFeedView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityFeedView()
            .environment(\.colorScheme, .light)
    }
}

