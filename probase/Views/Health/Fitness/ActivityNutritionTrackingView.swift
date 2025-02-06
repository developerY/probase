//
//  ActivityNutritionTrackingView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/5/25.
//
import SwiftUI

struct ActivityNutritionTrackingView: View {
    // Dummy activity data
    let steps: Int = 8000
    let distance: Double = 6.0    // in kilometers
    let activeMinutes: Int = 45
    
    // Dummy nutrition data
    let calories: Int = 1800
    let protein: Int = 120        // in grams
    let carbs: Int = 200          // in grams
    let fats: Int = 60            // in grams
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient: from green to blue
                LinearGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.3), Color.blue.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Daily Activity Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Daily Activity")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            // Activity Stats Row using StatTileViewFitness
                            HStack(spacing: 16) {
                                StatTileViewFitness(title: "Steps", value: "\(steps)")
                                StatTileViewFitness(title: "Distance", value: String(format: "%.1f km", distance))
                                StatTileViewFitness(title: "Active", value: "\(activeMinutes) min")
                            }
                            .padding(.horizontal)
                        }
                        
                        Divider()
                        
                        // Nutrition Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Nutrition")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            // Nutrition Stats Row using StatTileViewFitness
                            HStack(spacing: 16) {
                                StatTileViewFitness(title: "Calories", value: "\(calories) kcal")
                                StatTileViewFitness(title: "Protein", value: "\(protein) g")
                                StatTileViewFitness(title: "Carbs", value: "\(carbs) g")
                                StatTileViewFitness(title: "Fats", value: "\(fats) g")
                            }
                            .padding(.horizontal)
                            
                            // Action Buttons for Logging Meals/Water
                            HStack(spacing: 16) {
                                QuickActionButtonView(title: "Log Meal", systemImageName: "fork.knife")
                                QuickActionButtonView(title: "Log Water", systemImageName: "drop.fill")
                            }
                            .padding(.horizontal)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical)
                } // ScrollView
            } // ZStack
            .navigationTitle("Activity & Nutrition")
        }
    }
}

// Reusable Stat Tile for Fitness Data


// Reusable Quick Action Button


struct ActivityNutritionTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityNutritionTrackingView()
            .environment(\.colorScheme, .light)
    }
}

