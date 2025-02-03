//
//  GlucoseHistoryView.swift
//  probase
//
//  Created by Siamak Ashrafi on 2/1/25.
//    @Published var readings: [GlucoseReading] = []
import SwiftUI

struct GlucoseHistoryView: View {
    @EnvironmentObject var dataStore: GlucoseDataStore
    @State private var isChartExpanded: Bool = true

    var body: some View {
        NavigationStack {
            ZStack {
                // Static Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [ .blue.opacity(0.4),.orange.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack {
                    // Expandable chart header with chevron
                    chartHeader(title: "Glucose History Chart", isExpanded: $isChartExpanded)

                    if isChartExpanded {
                        GlucoseHistoryChartView()
                            .environmentObject(dataStore)
                            //.transition(.move(edge: .top))
                            .animation(.easeInOut(duration: 0.3), value: isChartExpanded)
                    }

                    // Time Range Picker (Day/Week/Month)
                    Picker("Range", selection: .constant(0)) {
                        Text("Day").tag(0)
                        Text("Week").tag(1)
                        Text("Month").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .padding()

                    // Key stats row
                    HStack {
                        Text("Avg BG: 6.2")
                        Spacer()
                        Text("TIR: 74%")
                        Spacer()
                        Text("SD: 1.2")
                    }
                    .padding(.horizontal)

                    // Scrollable list of events with a transparent background
                    List {
                        Section(header: Text("Today")) {
                            ForEach(0..<5, id: \.self) { i in
                                HStack {
                                    Text("08:00 - 5.4 mmol/L")
                                    Spacer()
                                    Text("Fasting")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        Section(header: Text("Yesterday")) {
                            ForEach(0..<5, id: \.self) { i in
                                HStack {
                                    Text("10:00 - 6.8 mmol/L")
                                    Spacer()
                                    Text("Post-meal")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)  // Prevent List from covering the background
                }
                .navigationTitle("History")
                .padding()
            }
        }
    }

    // MARK: - Chart Header with Expand/Collapse Chevron
    private func chartHeader(title: String, isExpanded: Binding<Bool>) -> some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Image(systemName: isExpanded.wrappedValue ? "chevron.up" : "chevron.down")
                .foregroundColor(.secondary)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isExpanded.wrappedValue.toggle()
                    }
                }
        }
        .padding(8)
        .background(Color.purple.opacity(0.2))
        .cornerRadius(8)
    }
}

// MARK: - Preview
struct GlucoseHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        GlucoseHistoryView()
            .environmentObject(GlucoseDataStore(mockData: true))
    }
}
