//
//  ComprehensiveGlucoseDashboardView.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/31/25.
//
import SwiftUI
import Charts

struct ComprehensiveGlucoseDashboardView: View {
    @EnvironmentObject var dataStore: GlucoseDataStore
    
    // Accordion states
    @State private var isGlucoseExpanded = true
    @State private var isActiveInsulinExpanded = true
    @State private var isInsulinDeliveryExpanded = true
    @State private var isCarbsExpanded = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    // HEADER
                    headerSection
                    
                    // ACCORDION SECTIONS
                    glucoseSection
                    activeInsulinSection
                    insulinDeliverySection
                    carbSection
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Glucose Dashboard")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Randomize button to shuffle data & see animations
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Randomize") {
                        withAnimation(.easeInOut) {
                            dataStore.shuffleAllData()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - HEADER
    private var headerSection: some View {
        HStack(alignment: .center, spacing: 16) {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.green, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: 50, height: 50)
                .overlay(
                    Text(timeAgoString())
                        .font(.caption2)
                        .foregroundColor(.secondary)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(String(format: "%.1f", dataStore.currentGlucose)) mmol/L")
                    .font(.title)
                    .bold()
                
                Text("Eventually \(String(format: "%.1f", dataStore.predictedGlucose)) mmol/L")
                    .font(.subheadline)
                    .foregroundColor(.orange)
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("+\(String(format: "%.2f", dataStore.activeInsulin)) U")
                    .font(.headline)
                    .foregroundColor(.yellow)
                Text("Active Insulin")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("\(String(format: "%.0f", dataStore.carbsOnBoard)) g")
                    .font(.headline)
                    .foregroundColor(.green)
                Text("Active Carbs")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - GLUCOSE SECTION
    private var glucoseSection: some View {
        VStack(spacing: 0) {
            accordionHeader(
                title: "Glucose",
                backgroundColor: .blue,
                isExpanded: $isGlucoseExpanded
            )
            if isGlucoseExpanded {
                GlucoseChartView()
                    .transition(.slide)              // Animate show/hide of the chart
                    .environmentObject(dataStore)
            }
        }
    }
    
    // MARK: - ACTIVE INSULIN SECTION
    private var activeInsulinSection: some View {
        VStack(spacing: 0) {
            accordionHeader(
                title: "Active Insulin",
                backgroundColor: .orange,
                isExpanded: $isActiveInsulinExpanded
            )
            if isActiveInsulinExpanded {
                ActiveInsulinChartView()
                    .transition(.slide)
                    .environmentObject(dataStore)
            }
        }
    }
    
    // MARK: - INSULIN DELIVERY SECTION
    private var insulinDeliverySection: some View {
        VStack(spacing: 0) {
            accordionHeader(
                title: "Insulin Delivery",
                backgroundColor: .yellow,
                isExpanded: $isInsulinDeliveryExpanded
            )
            if isInsulinDeliveryExpanded {
                InsulinDeliveryChartView()
                    .transition(.slide)
                    .environmentObject(dataStore)
            }
        }
    }
    
    // MARK: - CARBS SECTION
    private var carbSection: some View {
        VStack(spacing: 0) {
            accordionHeader(
                title: "Active Carbohydrates",
                backgroundColor: .green,
                isExpanded: $isCarbsExpanded
            )
            if isCarbsExpanded {
                CarbsChartView()
                    .transition(.slide)
                    .environmentObject(dataStore)
            }
        }
    }
    
    // MARK: - ACCORDION HEADER
    private func accordionHeader(
        title: String,
        backgroundColor: Color,
        isExpanded: Binding<Bool>
    ) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "chevron.down")
                .foregroundColor(.white)
                .rotationEffect(Angle(degrees: isExpanded.wrappedValue ? 0 : -90))
        }
        .padding(8)
        .background(backgroundColor)
        .cornerRadius(4)
        .onTapGesture {
            // Animate the expand/collapse
            withAnimation(.easeInOut) {
                isExpanded.wrappedValue.toggle()
            }
        }
    }
    
    // MARK: - Utility
    private func timeAgoString() -> String {
        guard let date = dataStore.lastUpdate else { return "--" }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

struct ComprehensiveGlucoseDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Preview in Light Mode on an iPhone 15 Pro
            ComprehensiveGlucoseDashboardView()
                .environmentObject(GlucoseDataStore())
                .previewDevice("iPhone 15 Pro")
                .previewDisplayName("iPhone 15 Pro - Light Mode")

            // Preview in Dark Mode on an iPhone SE (3rd generation)
            ComprehensiveGlucoseDashboardView()
                .environmentObject(GlucoseDataStore())
                .previewDevice("iPhone SE (3rd generation)")
                .preferredColorScheme(.dark)
                .previewDisplayName("iPhone SE (3rd gen) - Dark Mode")
        }
    }
}
