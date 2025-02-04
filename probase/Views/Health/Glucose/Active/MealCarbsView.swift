//
//  MealCarbsView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//
import SwiftUI

struct MealCarbsView: View {
    @State private var searchQuery = ""
    // Suppose we have a mock array of foods:
    let foodDatabase = [
        ("Apple", 15),
        ("Banana", 27),
        ("Oatmeal (1 cup)", 25),
        ("Sandwich", 30)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [.mint.opacity(0.4), .cyan.opacity(0.6)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Custom Search Bar
                    
                    TextField("Search foods...", text: $searchQuery)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    List {
                        Section("Favorites") {
                            // Hard-coded favorites for demonstration
                            FoodRow(name: "Apple", carbs: 15)
                            FoodRow(name: "Sandwich", carbs: 30)
                        }
                        
                        Section("Search Results") {
                            ForEach(filteredFoods(), id: \.0) { item in
                                FoodRow(name: item.0, carbs: item.1)
                            }
                        }
                    }
                }.scrollContentBackground(.hidden)  // Removes the default form background
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(16)

            }.navigationTitle("Meals & Carbs")
        }
    }

    private func filteredFoods() -> [(String, Int)] {
        if searchQuery.isEmpty { return foodDatabase }
        return foodDatabase.filter {
            $0.0.localizedCaseInsensitiveContains(searchQuery)
        }
    }
}

struct FoodRow: View {
    let name: String
    let carbs: Int

    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text("\(carbs) g")
                .foregroundColor(.secondary)
        }
    }
}


// MARK: - Preview
struct MealCarbsView_Previews: PreviewProvider {
    static var previews: some View {
        MealCarbsView()
            .preferredColorScheme(.light)
    }
}
