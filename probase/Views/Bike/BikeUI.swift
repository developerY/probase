//
//  BikeUI.swift
//  probase
//
//  Created by Siamak Ashrafi on 1/27/25.
//
import SwiftUI
import MapKit
import Charts

struct BikeView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @State private var currentSpeed: Double = 15.0
    @State private var distanceTraveled: Double = 12.5
    @State private var elevationGain: Double = 220
    @State private var heartRate: Int = 120
    
    @State private var speedData: [SpeedEntry] = (0..<20).map {
        SpeedEntry(time: Double($0), speed: Double.random(in: 10...20))
    }
    
    // Track whether the map is shown or hidden
    @State private var showMap = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.green.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                        // MARK: - Custom Header
                        HStack {
                            Text("Bike Tracker")
                                .font(.largeTitle.weight(.bold))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            // Toggle Button for Map
                            Button {
                                withAnimation(.easeInOut) {
                                    showMap.toggle()
                                }
                            } label: {
                                Image(systemName: showMap
                                      ? "chevron.up.circle.fill"
                                      : "chevron.down.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, 20)
                        .padding(.horizontal)
                        
                        // MARK: - Map (Hideable)
                        if showMap {
                            Map(coordinateRegion: $region)
                                .frame(height: 250)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                .padding(.horizontal)
                                .transition(.asymmetric(
                                    insertion: .move(edge: .top).combined(with: .opacity),
                                    removal: .move(edge: .top).combined(with: .opacity)
                                ))
                        }
                        
                        // MARK: - Stats Cards
                        HStack(spacing: 16) {
                            StatCard(iconName: "hare.fill",
                                     statName: "Speed",
                                     statValue: "\(String(format: "%.1f", currentSpeed)) km/h")
                            StatCard(iconName: "map.fill",
                                     statName: "Distance",
                                     statValue: "\(String(format: "%.1f", distanceTraveled)) km")
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: 16) {
                            StatCard(iconName: "figure.run",
                                     statName: "Heart Rate",
                                     statValue: "\(heartRate) bpm")
                            StatCard(iconName: "arrow.up.right.circle.fill",
                                     statName: "Elevation",
                                     statValue: "\(Int(elevationGain)) m")
                        }
                        .padding(.horizontal)
                        
                        // MARK: - Speed Chart
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Speed Over Time")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Chart {
                                ForEach(speedData) { entry in
                                    LineMark(
                                        x: .value("Time", entry.time),
                                        y: .value("Speed", entry.speed)
                                    )
                                    .foregroundStyle(.white)
                                }
                            }
                            .chartYAxis {
                                AxisMarks(position: .leading)
                            }
                            .frame(height: 200)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 20)
                        
                        // MARK: - Action Buttons
                        HStack(spacing: 16) {
                            Button(action: {
                                // Start ride action
                            }) {
                                Label("Start Ride", systemImage: "play.fill")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(.green)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                // Pause ride action
                            }) {
                                Label("Pause", systemImage: "pause.fill")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(.orange)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    }
                }
            }
            // Hide default nav bar
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}



// MARK: - StatCard Component (Frosted Glass)
struct StatCard: View {
    let iconName: String
    let statName: String
    let statValue: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: iconName)
                .font(.title)
                .foregroundColor(.white)
            
            Text(statName)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
            
            Text(statValue)
                .font(.headline.bold())
                .foregroundColor(.white)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    BikeView()
}

