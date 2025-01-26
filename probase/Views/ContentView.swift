//
//  ContentView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/25/25.
//
import SwiftUI


struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Apps", systemImage: "house.fill") {
                GlobalNavigationView()
            }
            Tab("Friends", systemImage: "person.and.person") {
                FriendListView()
            }
            Tab("Movies", systemImage: "film.stack") {
                MovieListView()
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
