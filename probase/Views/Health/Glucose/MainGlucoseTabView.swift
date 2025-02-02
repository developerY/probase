//
//  MainGlucoseTabView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI

/// The main tab bar with different feature screens
struct MainGlucoseTabView: View {
    var body: some View {
        TabView {
            HomeDashboardView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            GlucoseHistoryView()
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("History")
                }

            QuickLogView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Log")
                }

            MealCarbsView()
                .tabItem {
                    Image(systemName: "fork.knife.circle.fill")
                    Text("Meals")
                }

            SettingsProfileView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
        }
    }
}


// MARK: - Preview
struct MainGlucoseTabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainGlucoseTabView()
                .environmentObject(DiabetesDataStore())
                .previewDisplayName("Light Mode")

            MainGlucoseTabView()
                .environmentObject(DiabetesDataStore())
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
        }
    }
}
