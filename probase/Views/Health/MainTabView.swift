//
//  MainTabView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            //ComprehensiveGlucoseDashboardView()
            Text("Blood")
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                    Text("Dashboard")
                }

            Text("Meal")
                .tabItem {
                    Image(systemName: "fork.knife.circle.fill")
                    Text("Meal")
                }

            Text("Bolus")
                .tabItem {
                    Image(systemName: "drop.circle.fill")
                    Text("Bolus")
                }

            Text("Heart")
                .tabItem {
                    Image(systemName: "heart.circle.fill")
                    Text("Health")
                }

            Text("Settings")
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}

