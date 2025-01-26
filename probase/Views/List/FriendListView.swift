//
//  FriendListView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/25/25.
//
import SwiftUI
import SwiftData


struct FriendListView: View {
    @Query(sort: \Friend.name) private var friends: [Friend]
    @Environment(\.modelContext) private var context


    var body: some View {
        NavigationSplitView {
            List {
                ForEach(friends) { friend in
                    NavigationLink(friend.name) {
                        Text("Detail view for \(friend.name)")
                            .navigationTitle("Friend")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
            .navigationTitle("Friends")
        } detail: {
            Text("Select a friend")
                .navigationTitle("Friend")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    FriendListView()
        .modelContainer(SampleData.shared.modelContainer)
}


