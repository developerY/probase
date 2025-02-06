//
//  MealLoggingView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/6/25.
//
import SwiftUI

struct MealLoggingView: View {
    // Meal types for selection.
    let mealTypes = ["Breakfast", "Lunch", "Dinner", "Snack"]
    
    // MARK: - State Properties for Form Inputs
    @State private var selectedMealType = "Breakfast"
    @State private var mealTime = Date()
    @State private var calories: String = ""
    @State private var carbs: String = ""
    @State private var protein: String = ""
    @State private var mealNotes: String = ""
    
    // State for showing the saved animation.
    @State private var mealSaved: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient: from orange to green.
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.3), Color.green.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Screen Title with an SF Symbol.
                        HStack(spacing: 8) {
                            Image(systemName: "fork.knife")
                                .font(.largeTitle)
                                .foregroundColor(.primary)
                            Text("Log Meal")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }
                        .padding(.top)
                        
                        // Meal Type & Meal Time Section
                        VStack(spacing: 16) {
                            HStack {
                                Image(systemName: "fork.knife")
                                    .foregroundColor(.primary)
                                Text("Meal Type:")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                Picker("Meal Type", selection: $selectedMealType) {
                                    ForEach(mealTypes, id: \.self) { type in
                                        Text(type).tag(type)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                            }
                            
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundColor(.primary)
                                Text("Meal Time:")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                DatePicker("", selection: $mealTime, displayedComponents: [.date, .hourAndMinute])
                                    .labelsHidden()
                                    .datePickerStyle(CompactDatePickerStyle())
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // Nutrition Input Section
                        VStack(spacing: 16) {
                            HStack {
                                Image(systemName: "flame.fill")
                                    .foregroundColor(.red)
                                Text("Calories:")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                TextField("e.g., 500", text: $calories)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 100)
                            }
                            
                            HStack {
                                Image(systemName: "leaf.fill")
                                    .foregroundColor(.green)
                                Text("Carbs (g):")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                TextField("e.g., 60", text: $carbs)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 100)
                            }
                            
                            HStack {
                                Image(systemName: "bolt.fill")
                                    .foregroundColor(.yellow)
                                Text("Protein (g):")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                TextField("e.g., 20", text: $protein)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 100)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.9))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // Meal Notes Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Notes:")
                                .font(.headline)
                                .foregroundColor(.primary)
                            TextEditor(text: $mealNotes)
                                .frame(height: 100)
                                .padding(4)
                                .background(Color(.systemBackground).opacity(0.9))
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        
                        // Save Meal Button
                        Button(action: {
                            // Simulate saving the meal.
                            withAnimation {
                                mealSaved = true
                            }
                            
                            // Print details to the console (or implement your save logic).
                            print("Meal logged:")
                            print("Meal Type: \(selectedMealType)")
                            print("Meal Time: \(mealTime)")
                            print("Calories: \(calories)")
                            print("Carbs: \(carbs)")
                            print("Protein: \(protein)")
                            print("Notes: \(mealNotes)")
                            
                            // Hide the checkmark after 1.5 seconds.
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    mealSaved = false
                                }
                            }
                        }) {
                            Text("Save Meal")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                        Spacer()
                    }
                    .padding(.vertical)
                }
                
                // Animated Checkmark Overlay
                if mealSaved {
                    VStack {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 100))
                            .foregroundColor(.green)
                            .transition(.scale)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.2))
                    .ignoresSafeArea()
                }
            }
            .navigationTitle("Meal Logging")
        }
    }
}

struct MealLoggingView_Previews: PreviewProvider {
    static var previews: some View {
        MealLoggingView()
            .environment(\.colorScheme, .light)
    }
}
